Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291154AbSBLQOb>; Tue, 12 Feb 2002 11:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291151AbSBLQOV>; Tue, 12 Feb 2002 11:14:21 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:46619 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S291154AbSBLQOR>;
	Tue, 12 Feb 2002 11:14:17 -0500
Date: Wed, 13 Feb 2002 01:14:05 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: NyQuist <NyQuist@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nm256_audio.o
Message-Id: <20020213011405.4f9f3c41.bruce@ask.ne.jp>
In-Reply-To: <1013529735.9204.23.camel@stinky.pussy>
In-Reply-To: <1013529735.9204.23.camel@stinky.pussy>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Feb 2002 16:02:15 +0000
NyQuist <NyQuist@ntlworld.com> wrote:

> Hi
> I've a problem with this module. For some reason it locks up my laptop
> when modprobed. I'm running redhat's 2.4.7-10 on an i686 and i'm using
> the neomagic 256 chipset which I believe is a graphics/sound combination
> (with 4 meg or so of mem), the comp is a dell latitude ls.
> The card does work, as it runs under the commercial oss drivers, thing
> is because the machine locks tight running the kernel 256_audio, I can't
> get any debug information, the machine has to be physically
> unplugged/debatteried (lucky I run ext3 :) Not even a messages error. 
> Anyone with any info? I'm gonna have a look and try to debug, but i'm no
> kernel hacker.

A vague memory of when I used to use a neomagic-based laptop tells me that you
might want to try giving lilo (or whatever bootmanager you're using) a
parameter to limit your memory to 1MB less than your actual memory... although
this is from way back in 2.2.[789] days, I think. (For lilo, that would mean
typing mem=xxxM or adding append="mem=xxxM" to /etc/lilo.conf, where xxx is
your total RAM minus 1.)
