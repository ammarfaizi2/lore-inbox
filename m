Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291298AbSBNKCF>; Thu, 14 Feb 2002 05:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291383AbSBNKBz>; Thu, 14 Feb 2002 05:01:55 -0500
Received: from gwyn.tux.org ([207.96.122.8]:23971 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id <S291355AbSBNKBq>;
	Thu, 14 Feb 2002 05:01:46 -0500
Date: Thu, 14 Feb 2002 05:01:45 -0500
From: Timothy Ball <timball@tux.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: /proc/bus/pnp wierdness in 2.4.18-pre8-mjc
Message-ID: <20020214100145.GA22545@gwyn.tux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So this is a neat trick: 

--snip--snip--snip--
timball@delillo {44}$ uname -a
Linux delillo 2.4.18-pre8-mjc #1 Tue Feb 12 00:26:33 EST 2002 i586
unknown
timball@delillo {45}$ pwd
/proc/bus
timball@delillo {46}$ ls -lai
total 0
   4131 dr-xr-xr-x    6 root     root            0 Feb 14 04:50 ./
      1 dr-xr-xr-x   66 root     root            0 Feb 14 04:31 ../
   4500 dr-xr-xr-x    4 root     root            0 Feb 14 04:58 pccard/
   4384 dr-xr-xr-x    3 root     root            0 Feb 14 04:58 pci/
   4459 dr-xr-xr-x    3 root     root            0 Feb 14 04:58 pnp/
   4459 dr-xr-xr-x    3 root     root            0 Feb 14 04:58 pnp/
timball@delillo {47}$ ls
pccard/  pci/  pnp/  pnp/
--snip--snip--snip--

I'll be running a new -rc1 kernel by later this morning... I'll see if
it goes away, but I assume it's an out by one error. If it's still there
I'll hope to post more info.

--timball

-- 
	GPG key available on pgpkeys.mit.edu
pub  1024D/511FBD54 2001-07-23 Timothy Lu Hu Ball <timball@tux.org>
Key fingerprint = B579 29B0 F6C8 C7AA 3840  E053 FE02 BB97 511F BD54
