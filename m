Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267402AbSKPXi0>; Sat, 16 Nov 2002 18:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267403AbSKPXiZ>; Sat, 16 Nov 2002 18:38:25 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:37297 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267402AbSKPXiZ>; Sat, 16 Nov 2002 18:38:25 -0500
Subject: Re: [lart] /bin/ps output
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021116092424.GY22031@holomorphy.com>
References: <3DA798B6.9070400@us.ibm.com> 
	<20021116092424.GY22031@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 00:11:35 +0000
Message-Id: <1037491895.24777.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill - so what happens if you trim down the aio, event and ksoftirqd
threads to a sane size (you might also want to do something about the
fact 2.5 still runs ksoftirq too easily). Intuitively I'd go for a
square root of the number of processors + 1 sort of function but what do
the benchmarks say ?


