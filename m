Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbSJPLkT>; Wed, 16 Oct 2002 07:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261822AbSJPLkT>; Wed, 16 Oct 2002 07:40:19 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:22998 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261435AbSJPLkS>; Wed, 16 Oct 2002 07:40:18 -0400
Date: Wed, 16 Oct 2002 13:46:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mapping 36 bit physical addresses into 32 bit virtual
In-Reply-To: <aoi6bb$309$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.3.96.1021016133123.14774F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Oct 2002, H. Peter Anvin wrote:

> Oh no, the x86 madness is spreading!!!!
> 
> (It's depressing this happening on a MIPS system, which has been 64
> bits since who-knows-when...)

 Yep, but the reasons are different -- the embedded people are paranoid on
cutting away any possible bit of silicon and, admittedly, they are right,
to some extent.  Why do they need 36-bit physical addressing in 32-bit
cores remains a mystery to me, though, yet the MIPS32 ISA spec permits up
to 36 bits (implementation-specific) here.  Even more interesting is why
an implementation chose mapping of I/O devices there -- it's usually
easier for an OS to have them mapped within the low 29-bit address space
where they can be accessed bypassing the TLB. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

