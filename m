Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTEJDpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 23:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTEJDpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 23:45:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27658 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263643AbTEJDpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 23:45:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use correct x86 reboot vector
Date: 9 May 2003 20:58:09 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9htch$629$1@cesium.transmeta.com>
References: <20030510025634.GA31713@averell> <20030510033504.GA1789@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030510033504.GA1789@zip.com.au>
By author:    CaT <cat@zip.com.au>
In newsgroup: linux.dev.kernel
>
> On Sat, May 10, 2003 at 04:56:34AM +0200, Andi Kleen wrote:
> > Extensive discussion by various experts on the discuss@x86-64.org
> > mailing list concluded that the correct vector to restart an 286+ 
> > CPU is f000:fff0, not ffff:0000. Both seem to work on current systems, 
> > but the first is correct.
> 
> Could this bug, by any chance, cause a system to shutdown instead of
> rebooting? This is what happens to me at the moment but not each and
> every time.
> 

No, it wouldn't.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
