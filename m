Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUCQRaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 12:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUCQRaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 12:30:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13762 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261612AbUCQRaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 12:30:06 -0500
Date: Wed, 17 Mar 2004 09:29:59 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: pingc@wacom.com
Cc: vojtech@suse.cz, zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Wacom USB driver patch
Message-Id: <20040317092959.5e00fab4.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.58L.0402262354190.1653@logos.cnet>
References: <Pine.LNX.4.58L.0402262354190.1653@logos.cnet>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ping,

Vojtech posted your 2.6 patch to linux-kernel yesterday, so I examined it
(Subject: [PATCH 32/44] Update of Wacom driver from Ping Cheng (from Wacom)).
Unlike the 2.4 version, it does not feature a reset thread. Please tell
me why that thread was required in 2.4.

Or perhaps it was present in your original submission which I lost and
Vojtech removed that element of the patch?

Yours truly,
-- Pete

> Date: Fri, 20 Feb 2004 14:29:04 -0800
> From: Ping Cheng <pingc@wacom.com>
> To: 'Vojtech Pavlik ' <vojtech@suse.cz>, 'Pete Zaitcev ' <zaitcev@redhat.com>
> Cc: "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>
> Subject: RE: Wacom USB driver patch
> 
>  <<wacom_2.4.patch>>
> The attached patch is against the latest versions of wacom.c and hid-core.c
> at  http://linux.bkbits.net:8080/linux-2.4.
> 
> Ping
> 
> -----Original Message-----
> From: Vojtech Pavlik
> To: Pete Zaitcev
> Cc: Ping Cheng; linux-kernel@vger.kernel.org
> Sent: 2/13/04 12:13 AM
> Subject: Re: Wacom USB driver patch
> 
> On Thu, Feb 12, 2004 at 07:28:09PM -0800, Pete Zaitcev wrote:
> > On Thu, 12 Feb 2004 16:55:47 -0800
> > Ping Cheng <pingc@wacom.com> wrote:
> >
> > > The wacom.c at http://linux.bkbits.net:8080/linux-2.4 is way out of date and
> > > people are still working on/using 2.4 releases. Should I make a patch for
> > > 2.4?
> >
> > We plan to support 2.4 based releases for several years yet. If Vojtech
> > approves what you did for 2.6, I am all for a backport to Marcelo tree.
> > Marcelo is not very forthcoming with approvals these days, but perhaps
> > it may be folded into some update. But as usual I would like to avoid
> > carrying a patch in Red Hat tree, if at all possible.
> 
> Agreed. Same for us at SUSE.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
