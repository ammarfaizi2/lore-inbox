Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319334AbSHOBfv>; Wed, 14 Aug 2002 21:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319335AbSHOBfv>; Wed, 14 Aug 2002 21:35:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:56826 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319334AbSHOBfu>; Wed, 14 Aug 2002 21:35:50 -0400
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Willy Tarreau <willy@w.ods.org>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D5B03A5.5050703@zytor.com>
References: <3D56B13A.D3F741D1@zip.com.au>	<Pine.NEB.4.44.0208132322340.1351-100000@mima
	 s.fachschaften.tu-muenchen.de>	<ajc095$hk1$1@cesium.transmeta.com>
	<20020814194019.A31761@bitwizard.nl>	<3D5AB250.3070104@zytor.com>
	<20020814204556.GA7440@alpha.home.local> 	<3D5AC481.2080505@zytor.com>
	<1029374634.28240.26.camel@irongate.swansea.linux.org.uk> 
	<3D5B03A5.5050703@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 02:37:33 +0100
Message-Id: <1029375453.28240.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-15 at 02:28, H. Peter Anvin wrote:
> True indeed as well, although we should still have a busy_wait(); macro
> that can insert whatever hint instruction the architecture might or
> might not have.

We have one - its called cpu_relax()

