Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUAGOvW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 09:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUAGOvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 09:51:22 -0500
Received: from sp14.amenworld.com ([217.174.193.31]:42883 "EHLO
	nsrg-security.com") by vger.kernel.org with ESMTP id S265590AbUAGOvU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 09:51:20 -0500
Subject: Problems in 2.4.18 with madwifi
From: Lorenzo Hernandez Garcia-Hierro <lorenzohgh@nsrg-security.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Jan 2004 15:44:57 +0100
Message-Id: <1073486703.850.24.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having trouble on a madwifi installation :

When compiling wlan.o it tries to get the net/iw_handler.h but i am
running Debian with 2.4.18 ( i can boot with 2.4.18 , 2.4.22 and 2.6.0
).

Where is the problem ?
 Here are the little snippets of errors :

gcc -M -include ../include/compat.h -I../include -I.
-I/lib/modules/2.4.18/build/include
-I/lib/modules/2.4.18/build/arch/i386 -I..  -Wall -Wno-trigraphs -O2
-D__KERNEL__ -DMODULE -D__linux__ -fomit-frame-pointer
-DAH_BYTE_ORDER=AH_LITTLE_ENDIAN -fomit-frame-pointer if_ieee80211subr.c
if_ieee80211wireless.c if_media.c rc4.c > .depend
if_ieee80211wireless.c:54: net/iw_handler.h: No such file or directory
make[1]: *** [.depend] Error 1
make[1]: Leaving directory `/usr/src/madwifi/wlan'
make[1]: Entering directory `/usr/src/madwifi/driver'
rm -f .depend

Thanks in advance.
NOTE: I am installing it with 2.4.18 and a Orinoco b/g card from proxim
( atheros chip ).



