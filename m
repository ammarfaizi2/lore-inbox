Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287574AbSAEHMu>; Sat, 5 Jan 2002 02:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287573AbSAEHMk>; Sat, 5 Jan 2002 02:12:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20486 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287572AbSAEHM0>; Sat, 5 Jan 2002 02:12:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISA slot detection on PCI systems?
Date: 4 Jan 2002 23:12:17 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1690h$pci$1@cesium.transmeta.com>
In-Reply-To: <20020104211931.D5235@khan.acc.umu.se> <Pine.GSO.3.96.1020104212646.829L-100000@delta.ds2.pg.gda.pl> <20020104153646.D20097@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020104153646.D20097@thyrsus.com>
By author:    "Eric S. Raymond" <esr@thyrsus.com>
In newsgroup: linux.dev.kernel
> 
> Yes, that's almost the right solution (CONFIG_ISACARDS or CONFIG_MCA).  
> I'll add
> 
> 	require MCA != ISA_CARDS
> 
> to the rulebase.  Not that there are a lot of MCA machines out there but
> every little bit helps.
> 

Does that mean you can't build a kernel which will work on both kinds
of machines?  If so, start over, broken idea.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
