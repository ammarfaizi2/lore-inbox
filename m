Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSHDXZs>; Sun, 4 Aug 2002 19:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSHDXZs>; Sun, 4 Aug 2002 19:25:48 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:5020 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S318285AbSHDXZr>; Sun, 4 Aug 2002 19:25:47 -0400
Subject: [PATCH] 2.4.19 Bluetooth [5/5] BNEP support
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, bluez-devel@usw-pr-web.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1028460135.5549.69.camel@champ.qualcomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Aug 2002 04:28:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for BNEP (Bluetooth Network Encapsulation Protocol).
BNEP is an Ethernet emulation layer on top of Bluetooth L2CAP.

 Documentation/Configure.help |   13 
 net/bluetooth/Config.in      |    1 
 net/bluetooth/Makefile       |   15 
 net/bluetooth/bnep/Config.in |    6 
 net/bluetooth/bnep/Makefile  |   10 
 net/bluetooth/bnep/bnep.h    |  185 +++++++++++
 net/bluetooth/bnep/core.c    |  706 +++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/bnep/crc32.c   |   59 +++
 net/bluetooth/bnep/crc32.h   |   10 
 net/bluetooth/bnep/netdev.c  |  250 +++++++++++++++
 net/bluetooth/bnep/sock.c    |  238 ++++++++++++++
 11 files changed, 1489 insertions(+), 4 deletions(-)

http://bluez.sourceforge.net/patches/patch-2.4.19-bluetooth-bnep.gz

Patch should be applied on top of the previous 4 patches.
It's rather big (39KB) and therefor not inlined.

Please apply

Max

