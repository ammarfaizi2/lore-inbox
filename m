Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277950AbRJIUOc>; Tue, 9 Oct 2001 16:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277951AbRJIUON>; Tue, 9 Oct 2001 16:14:13 -0400
Received: from CM-46-145.chello.cl ([24.152.46.145]:25226 "EHLO
	ronto.dewback.cl") by vger.kernel.org with ESMTP id <S277949AbRJIUOC>;
	Tue, 9 Oct 2001 16:14:02 -0400
Date: Tue, 9 Oct 2001 16:13:47 -0400 (CLT)
From: Fabian Arias <dewback@vtr.net>
X-X-Sender: dewback@ronto.dewback.cl
To: seth goldberg <seth.goldberg@Sun.COM>
cc: linux-kernel@vger.kernel.org, <davem@redhat.com>
Subject: Re: sis900 does not work in 2.4.10
In-Reply-To: <3BC3569C.AF959299@Sun.COM>
Message-ID: <Pine.LNX.4.40.0110091609570.9480-100000@ronto.dewback.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, seth goldberg wrote:

> Hi,
>
>   I just upgraded to the ECS K7S5A Athlon M/B (SiS-735 based) and was
> trying to get the onboard SiS900 ethernet adapter working.  It works
> fine on 2.4.5, but when I try to get it going under 2.4.10, the only
>
>   Does anyone have any suggestions?

In my case, SiS630E based, also SiS900 eth :

ronto:~# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 21)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 83)
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630
GUI Accelerator+3D (rev 21)

ronto:~# uname -a
Linux ronto 2.4.10-ac9 #1 Mon Oct 8 14:06:53 CLT 2001 i686 unknown

100% Working.


>
>  Thanks,
>   Seth
>

 ---
 pub  1024D/0DD0F1CA 2001-09-19 Fabian A. Arias M. (dewback) <dewback@vtr.net>
     Key fingerprint = B478 850E 6C8A C388 2B65  68E5 9604 A4FC 0DD0 F1CA
              Debian GNU/Linux Sid - Kernel 2.4.10-ac9 - ReiserFS

