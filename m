Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbSJBMF3>; Wed, 2 Oct 2002 08:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbSJBMF3>; Wed, 2 Oct 2002 08:05:29 -0400
Received: from pl218.nas921.ichikawa.nttpc.ne.jp ([210.165.234.218]:47896 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S263067AbSJBMF2>;
	Wed, 2 Oct 2002 08:05:28 -0400
Date: Wed, 2 Oct 2002 21:10:26 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel makefiles broken?
Message-Id: <20021002211026.2a2c96e0.bruce@ask.ne.jp>
In-Reply-To: <20021002114028.C24770@flint.arm.linux.org.uk>
References: <20021002114028.C24770@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002 11:40:28 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> Hi,
> 
> I've noticed on two machines now that the kernel makefiles seem to have
> changed their behaviour.  One x86 RH-based, and one parisc debian based.
> 
> make seems to ignores errors from gcc, and only stops when trying to link.
> On a PARISC box, I've seen the build get all the way though to successfully
> linking vmlinux, even with compilation failures.  Obviously not ideal,
> since vmlinux may not reflect reality.

It looks like this change might have broken kbuild:

>> Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
>>   o kbuild: Make KBUILD_VERBOSE=0 work better under emacs

See the exchange between Adrian Bunk and Kai under the "Linux v2.5.40 - and a
feature freeze reminder" thread.

