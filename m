Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUDGKeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 06:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUDGKeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 06:34:00 -0400
Received: from [80.72.36.106] ([80.72.36.106]:8414 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261942AbUDGKd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 06:33:58 -0400
Date: Wed, 7 Apr 2004 12:33:52 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
In-Reply-To: <200404071222.21397.rjwysocki@sisk.pl>
Message-ID: <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net>
References: <200404071222.21397.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, R. J. Wysocki wrote:

> Hi,
> 
> FYI, I've just had a keyboard lockup on a Toshiba laptop (Satellite 1400-103) 
> with the 2.6.5 kernel.
> 
> It occured when I was typing some text in kmail.  Everything worked just fine 
> except for the keyboard that was locked (dead - even capslock did not work).  
> Fortunately the (USB) mouse worked, so I could reboot the machine "gently" to 
> get my keyboard back in order.
> 
> I use RH9 with some modifications to support the 2.6.x kernels.  Attached is 
> the .config.

Hi,

Was anything in your logs about that?

I think that maybe you should disable PREEMPTION.

Or use different distribution than RH9. They often modify gcc and other 
programs, maybe even X - maybe try to compile your kernel on "vanilla" gcc 
3.3.3. I can give you a shell on computer with Gentoo and working gcc. Or 
change distribution: Gentoo works ok for me and my friends! :-)


regards

Grzegorz Kulewski

