Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLRHjW>; Mon, 18 Dec 2000 02:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbQLRHjN>; Mon, 18 Dec 2000 02:39:13 -0500
Received: from pop.gmx.net ([194.221.183.20]:35548 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129450AbQLRHjE>;
	Mon, 18 Dec 2000 02:39:04 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Mon, 18 Dec 2000 08:02:23 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Peter Samuelson <peter@cadcamlab.org>,
        Mikael Djurfeldt <djurfeldt@nada.kth.se>
In-Reply-To: <E147oeY-0006H7-00@mdj.nada.kth.se> <20001218001135.Z3199@cadcamlab.org>
In-Reply-To: <20001218001135.Z3199@cadcamlab.org>
Subject: Re: 2.4.0-test13-pre3: Makefile problem in drivers/video
MIME-Version: 1.0
Message-Id: <00121808022301.00937@nmb>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

you may be right there is no module "video.o". The problem is, there should 
be a directory "media" under /lib/modules/2.4.0-test12.old/kernel/drivers/ 
and this is missing in test13pre2 and test13pre3. The modules are not built.

kind regards
Norbert


On Monday 18 December 2000 07:11, Peter Samuelson wrote:
> [Mikael Djurfeldt]
>
> > When trying to build video.o as a module, video.o doesn't get copied
> > to /lib/modules/* during installation.
>
> There is no video.o module.  If video.o is built at all, it is linked
> into the vmlinux image directly.  The modules in that directory will be
> atyfb.o, tdfxfb.o and about 800 others.
>
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
