Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272291AbRIMVbC>; Thu, 13 Sep 2001 17:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272415AbRIMVaw>; Thu, 13 Sep 2001 17:30:52 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:22276 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S272291AbRIMVae>; Thu, 13 Sep 2001 17:30:34 -0400
Message-ID: <3BA1258F.5CC18A2C@bluewin.ch>
Date: Thu, 13 Sep 2001 23:30:56 +0200
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How errorproof is ext2 fs?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reading the thread about "HFS Plus on Linux?" at
"debian-powerpc@list.debian.org" I had the following experience:

Within an hour I had to hard reset both of my computers, first my Linux-i386 due
to a complete lockup of the system while using el3diag, second my MacOS-powermac
due to an not responding USB-keyboard/-mouse (what a nice coincident). Now while
the Mac restarted without any fuse I had to fix the ext2-fs manually for about
15 min. Luckily it seems I haven't lost anything on both system. 

This leaves me a bad taste of Linux in my mouth. Does ext2 fs really behave so
worse in case of a crash? Okay Linux does not crash that often as MacOS does, so
it does not need a good  error proof fs. Still can't ext2 be made a little more
error proof?

Okay, there are other fs for Linux which cope better with such a situation, but
are they really more errorproof or are they just better in fixing up the mess
afterwards? Could there be more attention in not creating errors instead of
fixing them afterwards?

O. Wyss
