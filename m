Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSKKBCY>; Sun, 10 Nov 2002 20:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbSKKBCY>; Sun, 10 Nov 2002 20:02:24 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:39074 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265277AbSKKBCX>; Sun, 10 Nov 2002 20:02:23 -0500
Subject: Re: Memory performance on Serverworks GC-LE based system poor?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Martin Knoblauch <knobi@knobisoft.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021111005143.GA22055@suse.de>
References: <200211110130.13943.knobi@knobisoft.de> 
	<20021111005143.GA22055@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 01:33:30 +0000
Message-Id: <1036978410.2919.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 00:51, Dave Jones wrote:
> On Mon, Nov 11, 2002 at 01:30:13AM +0100, Martin Knoblauch wrote:
> 
>  >  I have experienced extreme low STREAMS numbers (about 600 MB/sec for Triad) 
>  > on two dual CPU systems based on the ServerWorks GC-LE chipset (SuperMicro 
>  > P4DLR+ mainboard). Both systems had 2x2.4 GHz XEONs, 4GB of DDR memory and 
>  > were running kernel 2.4.18. I would usually expect STREAMS numbers of about 
>  > 2000 MB/sec for this kind of systems.
>  > 
>  > Does this ring any bells?
> 
> ISTR serverworks LE errata with MTRRs and write-combining.
> Whether this is biting you or not I can't say.

Write combining would really only bite graphics cards. The only other
performance errata I know about affects the CIOB20 earlier revisions
(vendor serverworks id 0x0006)


