Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280301AbRJaQyl>; Wed, 31 Oct 2001 11:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280300AbRJaQyb>; Wed, 31 Oct 2001 11:54:31 -0500
Received: from pl475.nas921.ichikawa.nttpc.ne.jp ([210.165.235.219]:62750 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S280298AbRJaQyT>;
	Wed, 31 Oct 2001 11:54:19 -0500
Date: Thu, 1 Nov 2001 01:54:46 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20-pre12
Message-Id: <20011101015446.081df4c8.bruce@ask.ne.jp>
In-Reply-To: <20011031144156.A15003@lightning.swansea.linux.org.uk>
In-Reply-To: <20011031144156.A15003@lightning.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Er... I don't want to harp on the subject, but as I mentioned earlier, there's
a "\ No newline at end of file" in the patch block for arch/ppc/kernel/openpic.c
that gets introduced by later versions of diff, which causes problems for older
versions of patch (failing at that point with a malformed patch error).

If it's too much trouble, don't bother, but it'd be nice to have a patch that
applies cleanly on all my 2.2 boxes, without having to remember to fiddle with
it by hand... (OK, it's just an excuse to not upgrade patch :)


Bruce
