Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUBOILp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 03:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbUBOILp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 03:11:45 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:27264 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264361AbUBOILh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 03:11:37 -0500
Date: Sun, 15 Feb 2004 09:11:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard  and mouse driver module and lsmod in 2.6
Message-ID: <20040215081135.GC314@ucw.cz>
References: <Sea2-F67YP0QzBxhJTA00015551@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Sea2-F67YP0QzBxhJTA00015551@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 09:19:46AM +0200, sting sting wrote:
> Hello ,
> In 2.4, when you performed lsmod after boot (and after entering  X Windows)
> , if you had performed lsmod you had found that "keybdev" and "mousedev"  
> modules
> are loaded in momeory.
> 
> in 2.4, the  keybdev.c was under
> /linux-2.4-xxx/drivers/input/keybdev.c
> 
> Now, in 2.6 ,there is no keybdev.c and I assume there is also no keybdev.o 
> (am I right?
> I am not sure).
> On the other hand there is both /drivers/char/keyboard.c
> in 2.6 and 2.4 .
> 
> My question is :
> in 2.6, after boot and after starting x windows, when typing lsmod -
> what should be the parallel of keybdev.o ?
> 
> (I don't have in my 2.6, under /lib/modules/..., keybdev.o ; was I wrong
> in my configuration?)
> 
> even that I have no keybdev.o in my 2.6, ye the keyboard responds (at least
> for some minutes in the beginning).
> Or in 2.6 the keyboard driver is part of the kernel?).

In 2.6 keybdev.c is gone and it's functionality was put into keyboard.c

> and also - what is the parallel of mousedev.o ?
> I ***DO**** have mosedev.o under /drivers/input/mosedev.o but ***NOT*** 
> under
> the /lib/modules/2.6.0./.....
> 
> and also lsmod does not show mousedv.

mousedev on the other hand is still present in 2.6. Maybe you just did
not enable it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
