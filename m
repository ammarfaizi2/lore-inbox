Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030177AbWJXOIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030177AbWJXOIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWJXOIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:08:16 -0400
Received: from solarneutrino.net ([66.199.224.43]:6673 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1030177AbWJXOIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:08:16 -0400
Date: Tue, 24 Oct 2006 10:07:51 -0400
To: Avi Kivity <avi@argo.co.il>
Cc: Keith Whitwell <keith@tungstengraphics.com>,
       Keith Packard <keithp@keithp.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
Message-ID: <20061024140751.GA686@tau.solarneutrino.net>
References: <20061020164008.GA29810@tau.solarneutrino.net> <453E0556.4050301@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <453E0556.4050301@argo.co.il>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 02:21:42PM +0200, Avi Kivity wrote:
> Ryan Richter wrote:
> >
> >I had heard something previously about i965_dri.so maybe getting
> >miscompiled, but I hadn't followed up on it until now.  I rebuilt it
> >with an older gcc, and now it's all working great!  Sorry for the wild
> >goose chase.
> >
> 
> It was probably me.  I had the same experience, except that I recompiled 
> using the system compiler.  Possibly it got updated between the distro 
> compilation of the driver and my own.
> 
> So I don't think there's a need to try to reproduce it as it was 
> probably fixed in gcc already.
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=8384

It worked for me when I recompiled with -fno-strict-aliasing (or with an
older gcc - 3.4 rather than 4.1).

-ryan
