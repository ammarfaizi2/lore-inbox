Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262522AbREUW2s>; Mon, 21 May 2001 18:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262521AbREUW2i>; Mon, 21 May 2001 18:28:38 -0400
Received: from chia.umiacs.umd.edu ([128.8.120.111]:43228 "EHLO
	chia.umiacs.umd.edu") by vger.kernel.org with ESMTP
	id <S262520AbREUW2c>; Mon, 21 May 2001 18:28:32 -0400
Date: Mon, 21 May 2001 18:28:30 -0400 (EDT)
From: Adam <adam@cfar.umd.edu>
X-X-Sender: <adam@chia.umiacs.umd.edu>
To: <linux-kernel@vger.kernel.org>
Subject: debugging xterm. 
Message-ID: <Pine.GSO.4.33.0105211827350.18075-100000@chia.umiacs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to debug xterm and it seems like it is just not my day (I
suppose the "Abandon All Hope, Ye Who Enter Here" in the README for xterm
is for a reason there after all :P )

I running gdb on xterm. I'm running it as root, the current execution is
at main.c:main() and gdb seems to get lost when calling getuid), any idea?
Is there something special about getuid() I'm missing?

(gdb) next
1612                uid_t ruid = getuid();
2: screen->respond = 1448543468
1: screen = (TScreen *) 0x4000ae60
(gdb) next
1613                gid_t rgid = getgid();
2: screen->respond = Cannot access memory at address 0x4
Disabling display 2 to avoid infinite recursion.
(gdb)

it does not know where screen data structure is anymore..



-- 
Adam
http://www.eax.com	The Supreme Headquarters of the 32 bit registers



