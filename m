Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271537AbTGQSQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271553AbTGQSQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:16:16 -0400
Received: from ms-smtp-03.southeast.rr.com ([24.93.67.84]:24268 "EHLO
	ms-smtp-03.southeast.rr.com") by vger.kernel.org with ESMTP
	id S271537AbTGQSPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:15:22 -0400
Subject: Re: 2.6.0-test1 Vesa fb and Nvidia
From: "David St.Clair" <dstclair@cs.wcu.edu>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307171902530.10255-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0307171902530.10255-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1058466612.3179.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Jul 2003 14:30:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That was my problem.  Thank you very much!

David St.Clair


On Thu, 2003-07-17 at 14:03, James Simmons wrote:
> > I don't know if this is a hardware specific bug or I just don't have
> > something configured right.
> > 
> > If I try to boot using vga=792 (which works with 2.4.18) I get a blank
> > screen (but hard drive is actively booting). If I don't use vga= at all,
> > I get a normal boot without the penguin logo.
> > 
> > I am using Redhat 9 /w NVidia Geforce 4 420 64Mb.
> > 
> > CONFIG_VT=y
> > CONFIG_VT_CONSOLE=y
> > CONFIG_FB=y
> > CONFIG_FB_VGA16=y
> > CONFIG_FB_VESA=y
> > CONFIG_VIDEO_SELECT=y
> > CONFIG_VGA_CONSOLE=y
> > CONFIG_LOGO=y
> > CONFIG_LOGO_LINUX_MONO=y
> > CONFIG_LOGO_LINUX_VGA16=y
> > CONFIG_LOGO_LINUX_CLUT224=y
> 
> Where is CONFIG_FRAMEBUFFER_CONSOLE=y ???

