Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318320AbSGRSow>; Thu, 18 Jul 2002 14:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318321AbSGRSov>; Thu, 18 Jul 2002 14:44:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1781 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318320AbSGRSov>; Thu, 18 Jul 2002 14:44:51 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Robert Love <rml@tech9.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0207181930170.30902-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0207181930170.30902-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Jul 2002 20:58:43 +0100
Message-Id: <1027022323.8154.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 18:31, Szakacsits Szabolcs wrote:
> 
> On Thu, 18 Jul 2002, Szakacsits Szabolcs wrote:
> > And my point (you asked for comments) was that, this is only (the
> > harder) part of the solution making Linux a more reliable (no OOM
> > killing *and* root always has the control) and cost effective platform
> > (no need for occasionally very complex and continuous resource limit
> > setup/adjusting, especially for inexpert home/etc users).
> 
> Ahh, I figured out your target, embedded devices. Yes it's good for
> that but not enough for general purpose.

Adjusting the percentages to have a root only zone is doable. It helps
in some conceivable cases but not all. Do people think its important, if
so I'll add it

