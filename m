Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271988AbRH2O4n>; Wed, 29 Aug 2001 10:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271992AbRH2O4Z>; Wed, 29 Aug 2001 10:56:25 -0400
Received: from erm1.u-strasbg.fr ([130.79.74.61]:31751 "HELO erm1.u-strasbg.fr")
	by vger.kernel.org with SMTP id <S271988AbRH2O4O>;
	Wed, 29 Aug 2001 10:56:14 -0400
Date: Wed, 29 Aug 2001 17:07:52 +0200
From: Bruno Boettcher <bboett@erm1.u-strasbg.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [AMD] 79c970 ethernet card problems.....
Message-ID: <20010829170752.D2689@erm1.u-strasbg.fr>
Mail-Followup-To: Bruno Boettcher <bboett@erm1.u-strasbg.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010829152925.H1357@erm1.u-strasbg.fr> <3B8CF62F.69DA74C2@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B8CF62F.69DA74C2@inet.com>; from eli.carter@inet.com on Wed, Aug 29, 2001 at 09:03:27AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 09:03:27AM -0500, Eli Carter wrote:
> You might try the pcnet32 module instead of the lance module.
ok the result of using the pcnet32 module was a hard lock of my kernel,
had to remove the card to be able to boot again....
that's the part where it stops:
Aug 29 16:32:24 kalman kernel: eth1: PCnet/PCI 79C970 at 0xe000, warning
PROM address does not match CSR address<4>eth1: Probably a Compaq, using
the PROM address of 00 80 ad 11 09 20
Aug 29 16:32:24 kalman kernel: pcnet32: pcnet32_private lp=d0e4b000
lp_dma_addr=0x10e4b000 assigned IRQ 10.
Aug 29 16:32:24 kalman kernel: pcnet32.c:v1.25kf 26.9.1999
tsbogend@alpha.franken.de

after that nothing moves anymore.....

BTW forgot to say that's its an 2.4.9 kernel (debian source package)
running on an AMD Athlon...

-- 
ciao bboett
==============================================================
bboett@earthling.net
http://inforezo.u-strasbg.fr/~bboett http://erm1.u-strasbg.fr/~bboett
===============================================================
the total amount of intelligence on earth is constant.
human population is growing....
