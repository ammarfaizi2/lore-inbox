Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265994AbSKDNNN>; Mon, 4 Nov 2002 08:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbSKDNNM>; Mon, 4 Nov 2002 08:13:12 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1936 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265994AbSKDNNJ>; Mon, 4 Nov 2002 08:13:09 -0500
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is
	ugly
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
In-Reply-To: <1036372893.752.11.camel@phantasy>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
	<200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua> 
	<20021103103710.D10988@devserv.devel.redhat.com> 
	<1036340502.29642.36.camel@irongate.swansea.linux.org.uk> 
	<1036372893.752.11.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 13:41:07 +0000
Message-Id: <1036417267.1106.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 01:21, Robert Love wrote:
> I agree 100% we mark too much as inline - but at the same time, some
> larger functions are inline simply because they were originally part of
> another function and pulled out for cleanliness.  They are only used
> once...  in other words, in some cases I hope the kernel developers know
> what they are doing when they mark stuff inline.

gcc actually appears to know about that case for static functions.

