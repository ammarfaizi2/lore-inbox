Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318192AbSHDQ5Z>; Sun, 4 Aug 2002 12:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318193AbSHDQ5Z>; Sun, 4 Aug 2002 12:57:25 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:57336 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318192AbSHDQ5Y>; Sun, 4 Aug 2002 12:57:24 -0400
Subject: Re: 2.4.19 make allmodconfig - undefined symbols
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0208041802010.1422-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0208041802010.1422-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 19:18:38 +0100
Message-Id: <1028485118.14196.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 17:10, Adrian Bunk wrote:
> My impression is that nowadays it's extremely unlikely that someone tries
> to run a current 2.4 kernel on an a.out system - and since there weren't
> reports of people trying to build binfmt_elf as a module it seems noone
> actually hits this problem. Instead of exporting one symbol that is only
> needed in pathological setups I'd suggest the following patch to disallow
> the modular bulding of binfmt_elf:

If people want module ELF fine by me. The simpler fix is already in -ac,
which is to do the stack peturbation unconditionally.

