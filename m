Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSFERkm>; Wed, 5 Jun 2002 13:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSFERkl>; Wed, 5 Jun 2002 13:40:41 -0400
Received: from proton.optivus.com ([143.197.200.1]:56997 "EHLO
	proton.llumc.edu") by vger.kernel.org with ESMTP id <S315619AbSFERkl>;
	Wed, 5 Jun 2002 13:40:41 -0400
Subject: Re: promise PDC20267 onboard supermicro P3TDDE
From: Don Krause <dkrause@optivus.com>
To: William Thompson <wt@electro-mechanical.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020605132018.A4803@coredump.electro-mechanical.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Jun 2002 10:40:47 -0700
Message-Id: <1023298847.28445.40.camel@cartman.optivus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 10:20, William Thompson wrote:
> When I boot linux on this system and there is a disk attached to the promise
> connector, the system hard locks.  It finds the PDC20267 and the Via ide
> chipsets (in that order) and freezes here.  It doesn't show anything else.
> 
> I tried kernels 2.4.18 and 2.4.19-pre10.
> 
> I also tried making ide a module, loading ide-mod.o freezes as well.
> 
> Removing the hdd from the controller and it boots just fine.  I tried a
> Quantum fireball lct10 05 and a seagate st34311a with the same results.
> 
> The bios on the pdc controller is v1.31
> -

FWIW, I also have this exact problem on a MSI 694D Pro Ar Mainboard,
with an onboard Promise PDC20265.

Every kernel I've tried (up to 2.4.19-pre7) froze hard right after
detecting the promise controller. It only hangs if there is a (any)
device plugged into the controller.

(Don't have much more info at this point, I needed this box for work, so
it got stuck with w2k, while my primary linux box is a ump 566. <sigh>
I'd love to swap these two boxes, the 694 has a pair of 933's and a gig
of memory, and sits mostly idle)
-- 
Don Krause                                            

