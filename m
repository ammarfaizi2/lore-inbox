Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSIEAAP>; Wed, 4 Sep 2002 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSIEAAP>; Wed, 4 Sep 2002 20:00:15 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:27382
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316601AbSIEAAO>; Wed, 4 Sep 2002 20:00:14 -0400
Subject: RE: Problem on a kernel driver(SuSE, SMP)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8C18139EDEBC274AAD8F2671105F0E8E012704DB@cacexc02.americas.cpqcorp.net>
References: <8C18139EDEBC274AAD8F2671105F0E8E012704DB@cacexc02.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 01:05:32 +0100
Message-Id: <1031184332.2796.159.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agree, I'll fix it(thanks for noticing that), but it's not the point. 
> The point is THIS INSTRUCTION HANGS. NO RETURN FROM IT.

I only deal with people who use CAPITAL LETTER RANTS when paid 8)


Next guess is you didnt init the semaphore structure and it happened to
come out ok, but I find that unlikely to have worked in other cases.


