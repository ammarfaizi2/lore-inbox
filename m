Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSH0RUA>; Tue, 27 Aug 2002 13:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSH0RUA>; Tue, 27 Aug 2002 13:20:00 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63216 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314078AbSH0RUA>; Tue, 27 Aug 2002 13:20:00 -0400
Subject: Re: readsw/writesw readsl/writesl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020827.003027.26962443.davem@redhat.com>
References: <20020826.231157.10296323.davem@redhat.com>
	<Pine.LNX.4.10.10208262321150.24156-100000@master.linux-ide.org> 
	<20020827.003027.26962443.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 27 Aug 2002 18:25:24 +0100
Message-Id: <1030469124.5695.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-27 at 08:30, David S. Miller wrote:
> The only reason insl() exists is because the x86 has special
> instructions to perform that operation.
> 
> It used to be an optimization when cpus were really slow.

readsl becomes relevant once people start shipping bridges that can do
asynchronous pci mmio read or burst mode to order however

I wonder if thats something we should plan for now ?

