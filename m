Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWASSOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWASSOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWASSOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:14:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:55180 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161103AbWASSOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:14:30 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <20060119165832.GS19398@stusta.de>
References: <20060119030251.GG19398@stusta.de>
	 <20060118194103.5c569040.akpm@osdl.org>
	 <1137689071.4966.190.camel@dyn9047017102.beaverton.ibm.com>
	 <20060119165832.GS19398@stusta.de>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 10:14:47 -0800
Message-Id: <1137694497.4966.200.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 17:58 +0100, Adrian Bunk wrote:
> On Thu, Jan 19, 2006 at 08:44:31AM -0800, Badari Pulavarty wrote:
> >...
> > But again, its really useful to have raw driver to do simple "dd" tests
> > to test raw performance for disks (for comparing with filesystems, block
> > devices etc..). Without that, we need to add option to "dd" for
> > O_DIRECT.
> 
> The oflag=direct option was added to GNU coreutils in version 5.3.0.


Cool. It works - I have no complaints, then :)

# dd if=/dev/sda iflag=direct of=/dev/null bs=64k

Thanks,
Badari


