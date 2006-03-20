Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965675AbWCTQAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965675AbWCTQAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965664AbWCTQAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:00:18 -0500
Received: from mo01.po.2iij.net ([210.130.202.205]:64760 "EHLO
	mo01.po.2iij.net") by vger.kernel.org with ESMTP id S965675AbWCTQAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:00:09 -0500
Date: Tue, 21 Mar 2006 00:59:40 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 1/12] [MIPS] Improve description of VR41xx based
 machines
Message-Id: <20060321005940.35ce09f9.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060320131053.GA29434@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
	<20060320043902.GA20416@deprecation.cyrius.com>
	<20060320152646.1c5690e3.yoichi_yuasa@tripeaks.co.jp>
	<20060320131053.GA29434@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 13:10:53 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> * Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2006-03-20 15:26]:
> > > MIPS supports various NEC VR41XX chips and not just the VR4100.
> > > Update Kconfig accordingly, thereby bringing the file in sync with
> > > the linux-mips tree.
> > The linux-mips tree is older than kernel.org about this part.
> 
> Have you looked at the exact change I sent (I know that linux-mips has
> some older stuff, but the patch I sent was against linux-mips+new).
> IOW, is it more correct to say "VR4100" in Kconfig rather than
> "VR41XX", even though more CPUs than the VR4100 are supported?
> 
> All my patch does is a a/VR4100/VR41XX/, really.

VR4131 and VR4133, .... are included in NEC VR4100 series.
These entry have no problem.

Yoichi

see:
http://www.necel.com/micro/english/product/vr/vr.html

> 
> 
> > > -	bool "Support for NEC VR4100 series based machines"
> > > +	bool "Support for NEC VR41XX-based machines"
> ...
> > > -	  The options selects support for the NEC VR4100 series of processors.
> > > +	  The options selects support for the NEC VR41xx series of processors.
> > >  	  Only choose this option if you have one of these processors as a
