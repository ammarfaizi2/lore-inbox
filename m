Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbUKJHSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUKJHSL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 02:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUKJHSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 02:18:11 -0500
Received: from fmr12.intel.com ([134.134.136.15]:25023 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261507AbUKJHSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 02:18:08 -0500
Subject: Re: [PATCH] two sysdevs have same name
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Pallipadi Venkatesh <venkatesh.pallipadi@intel.com>
In-Reply-To: <1100069919.25061.11.camel@sli10-desk.sh.intel.com>
References: <1100069919.25061.11.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Message-Id: <1100070731.25497.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 15:12:11 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 14:58, Li Shaohua wrote:
> Hi,
> It takes me several days to debug a resume failure and I finally found
> it's a mis-merge. Two sysdevs (previous PIT and Timer, after Venki's
> HPET patch) use the same name 'timer'. Please feel free to select a
> different name.
> 
> PS. I'm surprised sysdev_class_register doesn't return an error in such
> situation.
Oops, please ignore it. Seems somebody else reported this issue before
me. Sorry for the noise.

Thanks,
Shaohua

