Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSJUPZC>; Mon, 21 Oct 2002 11:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbSJUPZC>; Mon, 21 Oct 2002 11:25:02 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:40628 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261404AbSJUPY7>; Mon, 21 Oct 2002 11:24:59 -0400
Subject: Re: [PATCH] compile fix for dmi_scan.c in 2.4.bk-current
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0210151702500.11036-100000@freak.distro.conectiva>
References: <Pine.LNX.4.44L.0210151702500.11036-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 16:46:43 +0100
Message-Id: <1035215203.28189.167.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-15 at 20:03, Marcelo Tosatti wrote:
> I'll remove the dmi update from Alan for 2.4.20-pre.
> 
> Thats a 2.4.21-pre thing.

Its very much a 2.4.20 thing. Its just that it accidentally acquired the
HP entry as well which we dont want.

Lose the problem function and the HP specific quirk and you'll get the
bits that actually do matter

