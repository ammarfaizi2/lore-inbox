Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWASQwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWASQwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWASQwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:52:49 -0500
Received: from rtr.ca ([64.26.128.89]:41367 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751398AbWASQws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:52:48 -0500
Message-ID: <43CFC3D0.1010607@rtr.ca>
Date: Thu, 19 Jan 2006 11:52:32 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
References: <20060119030251.GG19398@stusta.de>	 <20060118194103.5c569040.akpm@osdl.org> <1137689071.4966.190.camel@dyn9047017102.beaverton.ibm.com>
In-Reply-To: <1137689071.4966.190.camel@dyn9047017102.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
>
> But again, its really useful to have raw driver to do simple "dd" tests
> to test raw performance for disks (for comparing with filesystems, block
> devices etc..). Without that, we need to add option to "dd" for
> O_DIRECT.

Perhaps it's time for 'dd' to acquire something like the 'hdparm --direct' flag.
(and, oops, maybe I should add it to the man page for hdparm too!).

Cheers
