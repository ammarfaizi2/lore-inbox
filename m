Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266701AbUHCU63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266701AbUHCU63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUHCU62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:58:28 -0400
Received: from mail.dif.dk ([193.138.115.101]:15015 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266701AbUHCU6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:58:17 -0400
Date: Tue, 3 Aug 2004 23:02:56 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Marko Macek <marko.macek@gmx.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Eric Wong <eric@yhbt.net>
Subject: Re: KVM & mouse wheel
In-Reply-To: <410FAE9B.5010909@gmx.net>
Message-ID: <Pine.LNX.4.60.0408032257250.2821@dragon.hygekrogen.localhost>
References: <410FAE9B.5010909@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Marko Macek wrote:

> Hello!
> A few months ago I posted about problems with 2.6 kernel, KVM and mouse
> wheel.
> I was using 2.4 kernel until recently, but with the switch to FC2 with
> 2.6 kernel this problem became much more annoying.

I also had problems with my KVM switch and mouse when I initially moved to 
2.6, but adding this kernel boot parameter fixed it, meybe it will help 
you as well :  psmouse.proto=imps

My mouse was jumping all over the screen, clicking buttons at random, but 
since I added 
append="psmouse.proto=imps"
to my lilo.conf everything has been working perfectly with every 2.6 
kernel I've tried.

My mouse is a "Logitec MouseMan Wheel" (USB mouse, but connected to the 
KVM with a USB->PS/2 adapter), my KVM switch is an old 8port thing that I 
unfortunately don't know the name/brand of since I got it used and the 
label with that info on it is gone.

 Hope that helps you :)


--
Jesper Juhl <juhl-lkml@dif.dk>

