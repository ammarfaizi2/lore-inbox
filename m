Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSFFU7q>; Thu, 6 Jun 2002 16:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSFFU7o>; Thu, 6 Jun 2002 16:59:44 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:18585 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S317165AbSFFU6U> convert rfc822-to-8bit; Thu, 6 Jun 2002 16:58:20 -0400
Date: Thu, 6 Jun 2002 22:58:15 +0200
Message-Id: <200206062058.g56KwFX11306@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: Johannes Niediek <j.niediek@web.de>
To: linux-kernel@vger.kernel.org
Subject: IPX as module in kernel 2.4.18 has unresolved symbols
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody!

I have some trouble with IPX and kernel 2.4.18. I compiled the kernel with IPX-Support as M, but loading the module is not possible and produces the following output:

#>modprobe ipx
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: unresolved symbol unregister_8022_client_R7acef15d
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: unresolved symbol register_snap_client_R5a0e17ac
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: unresolved symbol make_EII_client
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: unresolved symbol make_8023_client
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: unresolved symbol destroy_8023_client
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: unresolved symbol destroy_EII_client
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: unresolved symbol unregister_snap_client_R9abefc50
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: unresolved symbol register_8022_client_R1eaa06ea
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: insmod /lib/modules/2.4.18/kernel/net/ipx/ipx.o failed
/lib/modules/2.4.18/kernel/net/ipx/ipx.o: insmod ipx failed

I read all documentation on this topic I found, but what I did not find were any comparable entries, except from an email on the same problem without any replays.

I hope that this question is not off topic or misplaced (it's my first post to linux-kernel...).

My .config can be made available at jniediek.schueler.cjd-braunschweig.de/config if neccessary.

Thank You,

Johannes Niediek
______________________________________________________________________________
All inclusive! 100 MB Speicher, SMS 50% günstiger, 32 MB Attachment-Größe, 
Preisvorteile und mehr unter http://club.web.de/?mc=021104

