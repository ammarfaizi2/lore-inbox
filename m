Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbSKPNR7>; Sat, 16 Nov 2002 08:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbSKPNR7>; Sat, 16 Nov 2002 08:17:59 -0500
Received: from elin.scali.no ([62.70.89.10]:44814 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267270AbSKPNR7>;
	Sat, 16 Nov 2002 08:17:59 -0500
Date: Sat, 16 Nov 2002 14:26:32 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: linux-kernel@vger.kernel.org
Subject: Xeon with HyperThreading and linux-2.4.20-rc2
In-Reply-To: <3DD536FB.70309@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0211161420080.6911-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've two boxes with Dual Xeons 1.8 GHz and HT option enabled in BIOS. When 
I boot 2.4.20-rc2 with default arguments the kernel detects 4 processors and 
also reports 4 processors in /proc/cpuinfo wiht the "ht" feature.

However, if I boot with the "noht" option (wich I believed turned off HT 
and therefore only two processors should be available), the kernel still 
detects 4 processors, _but_ now the "ht" feature in /proc/cpuinfo is not 
there. Is this the intention of the "noht" option ? If so, are there any 
options available to turn off HT support in the kernel completely, so that 
I don't have to go into the BIOS to turn it off ?

If you want to I can provide the dmesg output and .config.

I think this issue is not just related to 2.4.20-rc2, but earlier kernels 
aswell.

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

