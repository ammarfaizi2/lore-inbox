Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRIMOzR>; Thu, 13 Sep 2001 10:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271655AbRIMOzH>; Thu, 13 Sep 2001 10:55:07 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:8196 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S268861AbRIMOyt>; Thu, 13 Sep 2001 10:54:49 -0400
Message-ID: <3BA0C88D.6B170BD5@mediascape.de>
Date: Thu, 13 Sep 2001 16:54:05 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 and eepro100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got the 2.2.19 sorces, patched them with reiserfs, compiled and booted the
new kernel. Neither the builtin eepro100 nor Intels e100-1.6.13 driver
worked; they were loaded, but ifconfig failed:

+ ifconfig eth1 192.168.0.235 broadcast 192.168.0.255 netmask 255.255.255.0
up
SIOCSIFFLAGS: Resource temporarily unavailable
SIOCSIFFLAGS: Resource temporarily unavailable

What's wrong here? I want 2.2 because 2.4 eats up too much memory on my
machine, and I have only 256 MB... ;-)

Cheers
Olaf
