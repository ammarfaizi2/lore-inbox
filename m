Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUBOHTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUBOHTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:19:49 -0500
Received: from sea2-f67.sea2.hotmail.com ([207.68.165.67]:30222 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264283AbUBOHTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:19:47 -0500
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: keyboard  and mouse driver module and lsmod in 2.6 
Date: Sun, 15 Feb 2004 09:19:46 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F67YP0QzBxhJTA00015551@hotmail.com>
X-OriginalArrivalTime: 15 Feb 2004 07:19:46.0714 (UTC) FILETIME=[173DC7A0:01C3F394]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,
In 2.4, when you performed lsmod after boot (and after entering  X Windows)
, if you had performed lsmod you had found that "keybdev" and "mousedev"  
modules
are loaded in momeory.

in 2.4, the  keybdev.c was under
/linux-2.4-xxx/drivers/input/keybdev.c

Now, in 2.6 ,there is no keybdev.c and I assume there is also no keybdev.o 
(am I right?
I am not sure).
On the other hand there is both /drivers/char/keyboard.c
in 2.6 and 2.4 .

My question is :
in 2.6, after boot and after starting x windows, when typing lsmod -
what should be the parallel of keybdev.o ?

(I don't have in my 2.6, under /lib/modules/..., keybdev.o ; was I wrong
in my configuration?)

even that I have no keybdev.o in my 2.6, ye the keyboard responds (at least
for some minutes in the beginning).
Or in 2.6 the keyboard driver is part of the kernel?).

and also - what is the parallel of mousedev.o ?
I ***DO**** have mosedev.o under /drivers/input/mosedev.o but ***NOT*** 
under
the /lib/modules/2.6.0./.....

and also lsmod does not show mousedv.

regards,
sting

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE* 
http://join.msn.com/?page=features/junkmail

