Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSCOAKD>; Thu, 14 Mar 2002 19:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311872AbSCOAJx>; Thu, 14 Mar 2002 19:09:53 -0500
Received: from web10401.mail.yahoo.com ([216.136.130.93]:40861 "HELO
	web10401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311871AbSCOAJl>; Thu, 14 Mar 2002 19:09:41 -0500
Message-ID: <20020315000938.63500.qmail@web10401.mail.yahoo.com>
Date: Fri, 15 Mar 2002 11:09:38 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: Will XFree86-4.2.0 dri modules come to 2.4.x kernel? (Note for jp8 kernel)
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16leho-0002Et-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> All the modules should be compatible, except for the
> I830M which requires
> a new module not in XFree 4.1/DRM 4.1
> 
> The 4.2 modules are merged in 2.4.19-ac, but have

Sorry, this problem is with 2.4.19-pre3-jp8 kernel.
With 2.4.19-pre2-ac4 it is fine. I dont know why ;
here is from the log file

EE) I810(0): [dri] I810DRIScreenInit failed because of
a version mismatch.
[dri] i810.o kernel module version is 1.1.0 but
version 1.2 or greater is needed.
[dri] Disabling DRI.
(EE) I810(0): [drm] failed to remove DRM signal
handler
(II) I810(0): [drm] removed 1 reserved context for
kernel
DRIUnlock called when not locked
(II) I810(0): [drm] unmapping 8192 bytes of SAREA
0xc88c2000 at 0x40017000
(==) I810(0): Write-combining range
(0xd8000000,0x4000000)
(II) I810(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0,
hwp->PIOOffset is 0x0000
(II) I810(0): Setting dot clock to 40.0 MHz [ 0x8 0x1
0x30 ] [ 10 3 3 ]
(II) I810(0): chose watermark 0x22007000: (tab.freq
40.0)
(WW) I810(0): xf86AllocateGARTMemory: allocation of
1024 pages failed
        (Cannot allocate memory)
(II) I810(0): No physical mem
ory available for 4194304 bytes of DCACHE




=====
Steve Kieu

http://movies.yahoo.com.au - Yahoo! Movies
- Vote for your nominees in our online Oscars pool.
