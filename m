Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265685AbSKAKfr>; Fri, 1 Nov 2002 05:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265686AbSKAKfr>; Fri, 1 Nov 2002 05:35:47 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:65411 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S265685AbSKAKfq>;
	Fri, 1 Nov 2002 05:35:46 -0500
Date: Fri, 1 Nov 2002 04:41:30 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Gregoire Favre <greg@ulima.unil.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: Logitech wheel and 2.5? (PS/2)
In-Reply-To: <20021031223401.GB25356@ulima.unil.ch>
Message-ID: <Pine.LNX.4.44.0211010438550.22868-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Gregoire Favre wrote:

> Hello,
> 
> up to 2.5.45:
> 
> ...
> register interface 'mouse' with class 'input
> mice: PS/2 mouse device common for all mice
> input: PC Speaker
> input: PS2++ Logitech Wheel Mouse on isa0060/serio1
> ...
> psmouse.c: Received PS2++ packet #0, but don't know how to handle.
> psmouse.c: Received PS2++ packet #0, but don't know how to handle.
> ...
> 
> And very regulary my mouse position is lost and reseted???
> Also the wheel don't work (don't know for the button on the left that I
> never use: the 3 regulars one and the wheel are enough for me...).

How is your mouse configured/detected?  If your boot up sequence specifies 
to gpm that you have a Logitech Wheel Mouse try redoing it for an MS 
Intellimouse.  I have several Logitech mice which work as imps/2 and don't 
when configured as a logitech.

