Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSHEJnC>; Mon, 5 Aug 2002 05:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318359AbSHEJnC>; Mon, 5 Aug 2002 05:43:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23036 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318358AbSHEJnB>; Mon, 5 Aug 2002 05:43:01 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028539877.1572.108.camel@ldb>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb> 
	<1028498075.15200.29.camel@irongate.swansea.linux.org.uk> 
	<1028493814.26332.9.camel@ldb> 
	<1028505732.15495.38.camel@irongate.swansea.linux.org.uk> 
	<1028535126.1572.48.camel@ldb> 
	<1028540954.16550.26.camel@irongate.swansea.linux.org.uk> 
	<1028539877.1572.108.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 12:05:10 +0100
Message-Id: <1028545510.17780.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 10:31, Luca Barbieri wrote:
> I agree and the patch only adds sfence _if_ CONFIG_X86_OOSTORE is
> defined (and CONFIG_X86_MMXEXT is also defined)

If OOSTORE is defined then we can't safely use any mmx operations, so
this is all noise and its still the case no change is required


