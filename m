Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbSBMPEp>; Wed, 13 Feb 2002 10:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSBMPEf>; Wed, 13 Feb 2002 10:04:35 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:50978 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S285417AbSBMPEZ>;
	Wed, 13 Feb 2002 10:04:25 -0500
Date: Thu, 14 Feb 2002 00:03:15 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: jlnance@intrex.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where did my PS/2 mouse go?
Message-Id: <20020214000315.6fdb79a4.bruce@ask.ne.jp>
In-Reply-To: <20020213084521.A1604@tricia.dyndns.org>
In-Reply-To: <20020213084521.A1604@tricia.dyndns.org>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002 08:45:21 -0500
jlnance@intrex.net wrote:

> Hello All,
>     I just built and installed my first 2.5 kernel (2.5.4-dj1) and I am
> having a little problem with configuration.  It seems the input devices
> have changed around some and gpm no longer works.  I assume that I have
> the wrong options selected in the input section of the .config, but I
> dont see anything obviously wrong, and I did not see anything in the
> Documentation for Changes directory that I thought was relivant.  Any
> ideas?

Try starting gpm with 'gpm -m /dev/input/mice' and see if it works.
