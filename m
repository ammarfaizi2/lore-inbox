Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265839AbSKBAsM>; Fri, 1 Nov 2002 19:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265841AbSKBAsM>; Fri, 1 Nov 2002 19:48:12 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:3210 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265839AbSKBAsL>; Fri, 1 Nov 2002 19:48:11 -0500
Subject: Re: Kernel Panic during memcpy_toio to PCI card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "Matt D. Robinson" <yakker@aparity.com>,
       "Donepudi, Suneeta" <sdonepudi@3eti.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <20021101232948.GA7650@suse.de>
References: <EF5625F9F795C94BA28B150706A215480DF84D@MAIL>
	<Pine.LNX.4.44.0211011527460.27345-100000@nakedeye.aparity.com> 
	<20021101232948.GA7650@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 01:15:11 +0000
Message-Id: <1036199711.14840.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 23:29, Dave Jones wrote:
> memcpy_toio() in 2.4 is still using memcpy() which could use prefetch()
> if you compile for certain processors.  Prefetching io space could do
> all sorts of nasties.
> 

If so that really wants fixing ASAP ie for 2.4.20

