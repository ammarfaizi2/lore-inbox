Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTANLrR>; Tue, 14 Jan 2003 06:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbTANLrQ>; Tue, 14 Jan 2003 06:47:16 -0500
Received: from pl1310.nas921.ichikawa.nttpc.ne.jp ([219.102.249.30]:43065 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S262469AbTANLrM>;
	Tue, 14 Jan 2003 06:47:12 -0500
Date: Tue, 14 Jan 2003 20:55:56 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Paul Mackerras <paulus@samba.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: IPMI
Message-Id: <20030114205556.53695b7d.bruce@ask.ne.jp>
In-Reply-To: <15907.55035.787654.77224@argo.ozlabs.ibm.com>
References: <20030114084011.6AB412C466@lists.samba.org>
	<15907.55035.787654.77224@argo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14
 _qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq
 *)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003 20:23:07 +1100
Paul Mackerras <paulus@samba.org> wrote:

> > This document describes how to use the IPMI driver for Linux.  If you
> > are not familiar with IPMI itself, see the web site at
> > http://www.intel.com/design/servers/ipmi/index.htm.  IPMI is a big
> > subject and I can't cover it all here!

I don't want to start a license flamewar, by any means, but while looking
through that page I noticed this:

"Adopters Agreement:

Before implementing the IPMI, IPMB or ICMB specifications, a royalty-free
reciprocal patent license must be signed."

The agreement itself (at http://www.intel.com/design/servers/ipmi/adopterslicense.pdf)
seems benign (where 'seems' means 'I am not a lawyer and I don't even play one on TV'),
 but this bit looks a little iffy:

| Adopter hereby grants to the Promoters and to Fellow Adopters, and the
| Promoters hereby grant to Adopter, a nonexclusive, royalty-free,
| nontransferable, nonsublicenseable, worldwide
| license under its Necessary Claims to make, have made, use, import,
| offer to sell and sell products which comply with the Specification

How does the "nontransferable, nonsublicensable" bit affect Linux? I presume
somebody signed this thing and sent it to Intel, but wouldn't it only apply to
the individual who signed it, as Linux developers aren't exactly a legal
entity? The way I read it, it would mean that everybody who wants to
distribute a kernel containing IPMI would each need to sign the agreement...

Much as I hate to say it, have you had a GPL-aware lawyer look at this?

Sorry for the noise,

Bruce

