Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSIDX35>; Wed, 4 Sep 2002 19:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSIDX35>; Wed, 4 Sep 2002 19:29:57 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:12022
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316408AbSIDX34>; Wed, 4 Sep 2002 19:29:56 -0400
Subject: Re: PROBLEM:  Kernel 2.4.19 does not export _mmx_memcpy when
	compiled with gcc-3.2 and Athlon optimizations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phil Stracchino <alaric@babcom.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020904181952.GA1158@babylon5.babcom.com>
References: <20020904181952.GA1158@babylon5.babcom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 00:35:12 +0100
Message-Id: <1031182512.3017.139.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 19:19, Phil Stracchino wrote:
> PROBLEM SUMMARY:
> Kernel 2.4.19 apparently fails to export _mmx_memcpy when compiled with
> gcc-3.2 and Athlon optimizations

You need to save your .config make distclean, restore it make oldconfig
dep and build the kernel. Its a known limitation in the CML1 config
tools

