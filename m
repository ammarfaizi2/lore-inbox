Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314300AbSEIUfn>; Thu, 9 May 2002 16:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSEIUfm>; Thu, 9 May 2002 16:35:42 -0400
Received: from ua83d37hel.dial.kolumbus.fi ([62.248.234.83]:53354 "EHLO
	rankki.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S314300AbSEIUfm>; Thu, 9 May 2002 16:35:42 -0400
Message-ID: <3CDADD92.908001AB@kolumbus.fi>
Date: Thu, 09 May 2002 23:35:30 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: christian.burger@edb.ericsson.se
CC: linux-kernel@vger.kernel.org
Subject: Re: fonts corruption with 3dfx drm module
In-Reply-To: <3CDA61CA.498991DF@edb.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Burger wrote:
> 
> I've seen a much more serious problem which seems to be related to this:
> I have AMD Athlon K7 650MHz, Via chipset, Voodoo5 5500AGP, MTTR enabled.
> What is happening here is that when switching back from init 5 to init 3 
> for instance, the system hangs completely and a blinking character 
> appears in a black screen. There's no other way other than to power cycle 
> the system. It seems to be a kernel panic.
> Kernel version is 2.4.18, and it happens with or without DRM support, 
> with and without FB support. There's no way I can have this version of 
> the kernel to work here.

Same problem here, with AMD K6 and Voodoo3 2000 PCI. All kernels and all
XFree86 4.x.x versions. Although it doesn't hang the machine. Usually just
fonts in vc1 are messed up.

So, it's not MTRR nor AGP problem. It must be something in XFree86 tdfx
driver. Accelerated-X doesn't show this problem.


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

