Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318015AbSGLV4I>; Fri, 12 Jul 2002 17:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318019AbSGLV4G>; Fri, 12 Jul 2002 17:56:06 -0400
Received: from pD9E235D3.dip.t-dialin.net ([217.226.53.211]:14471 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318015AbSGLV4B>; Fri, 12 Jul 2002 17:56:01 -0400
Date: Fri, 12 Jul 2002 15:58:28 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Roman Zippel <zippel@linux-m68k.org>, <ultralinux@vger.kernel.org>
Subject: L1_CACHE_SHIFT on sparc64
Message-ID: <Pine.LNX.4.44.0207121553230.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What is the proper value for L1_CACHE_SHIFT on sparc64?
The cache itself is two chunks of 16 bytes each, makes up 32 bytes. On 
i386, L1_CACHE_BYTES == (1 << L1_CACHE_SHIFT), so if this applies here, 
too, we have a L1_CACHE_SHIFT of... 5?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

