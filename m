Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129538AbQK1QeR>; Tue, 28 Nov 2000 11:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129546AbQK1QeH>; Tue, 28 Nov 2000 11:34:07 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:36616 "EHLO
        tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
        id <S129538AbQK1Qdy>; Tue, 28 Nov 2000 11:33:54 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 28 Nov 2000 09:03:38 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E140UaD-0003ZI-00@the-village.bc.nu>
In-Reply-To: <E140UaD-0003ZI-00@the-village.bc.nu>
Subject: Re: 2.4.0-test11-ac2 and ac4 SMP will not run KDE 2.0
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00112809033800.01270@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
>Nod. It actually puzzles me since from the kernel view I doubt kde and gnome
>even look different at the syscall level. They may look different to X but
>X isnt the thing that changed

Steven Cole wrote:
>
>Tomorrow when I have access to the two-way P-III problem machine,
>I'll repatch 2.4.0-test11-ac4 with reiserfs-3.6.18,
>which is a little less bleeding edge than reiserfs-3.6.19.

2.4.0-test11-ac2 still freezes starting up KDE 2.0 when patched
with reiserfs-3.6.18.

2.4.0-test12-pre2 both SMP and UP builds also freeze when starting
up KDE 2.0 on this dual cpu box. Those test12-pre2 kernels are
patched with reiserfs-3.6.19.

I guess I'll have to switch over to using Gnome if I want to continue
using kernels later than 2.4.0-test11-ac1 and ReiserFS on this dual
P-III Dell 420.

Can someone else please see if this is reproducable?  

The ingredients are:

Dual CPU P-III.
2.4.0-test11-ac2 or later (test12-pre2)
SMP build for -acX. (X > 1).
ReiserFS 3.6.18 or 3.6.19.
KDE 2.0

Thanks very much.

Steven

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
