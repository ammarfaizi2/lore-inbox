Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSHLJKW>; Mon, 12 Aug 2002 05:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317633AbSHLJKV>; Mon, 12 Aug 2002 05:10:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:25080 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317623AbSHLJKU>; Mon, 12 Aug 2002 05:10:20 -0400
Subject: Re: [patch] tls-2.5.31-C3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       julliard@winehq.com, ldb@ldb.ods.org
In-Reply-To: <Pine.LNX.4.44.0208121246340.2955-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208121246340.2955-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 11:35:24 +0100
Message-Id: <1029148524.16424.141.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 11:49, Ingo Molnar wrote:
> but, couldnt APM use its own private GDT for real-mode calls, with 0x40
> filled in properly? That would pretty much decouple things.

Oh and secondly they are not actually real mode calls, they are
protected mode 32bit calls with certain segment registers set up to
point to specific things taken from the apm bios 32 interface

