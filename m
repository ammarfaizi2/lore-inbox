Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317464AbSHHLPV>; Thu, 8 Aug 2002 07:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSHHLPV>; Thu, 8 Aug 2002 07:15:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:42222 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317464AbSHHLPV>; Thu, 8 Aug 2002 07:15:21 -0400
Subject: Re: 2.4.19 BUG in page_alloc.c:91
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Anthony Russo., a.k.a. " Stupendous Man 
	<anthony.russo@verizon.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D51DB52.6000200@verizon.net>
References: <3D51DB52.6000200@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 13:38:56 +0100
Message-Id: <1028810336.28882.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 03:45, Anthony Russo., a.k.a. Stupendous Man
wrote:

> Aug  7 19:23:30 manic kernel: EIP:    0010:[<c012c331>]    Tainted: P
> Aug  7 19:23:30 manic kernel: EFLAGS: 00010286

Dulplicate the problem from a cold boot without ever having loaded
whatever module set the taint flag (ie wasnt a standard GPL one)

