Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSHFVmI>; Tue, 6 Aug 2002 17:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSHFVmI>; Tue, 6 Aug 2002 17:42:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48884 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315717AbSHFVmH>; Tue, 6 Aug 2002 17:42:07 -0400
Subject: Re: 2.4.19 See's incorrect cache size on P4 Xeons!?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1028669517.6549.100.camel@UberGeek.coremetrics.com>
References: <1028669517.6549.100.camel@UberGeek.coremetrics.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 00:04:56 +0100
Message-Id: <1028675096.18156.220.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On boot each processor is says it has 1MB L3, is 2.4.19 unable to read
> that or something?

At the moment we report the L1/L2 - we don't actually go decoding L3
caches. They are quite new. We should do however.

