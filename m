Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUCDMoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUCDMoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:44:18 -0500
Received: from ocelot.spots.ab.ca ([209.115.174.244]:16818 "EHLO
	ocelot.spots.ab.ca") by vger.kernel.org with ESMTP id S261872AbUCDMoQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:44:16 -0500
From: "john" <johnp@marine-boy.nu>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, Andrewm@uow.edu.au,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Problems getting a stable 100 megabit connection with linksys etherfast switch
Date: Thu, 4 Mar 2004 05:44:00 -0700
Message-Id: <20040304123913.M97501@marine-boy.nu>
In-Reply-To: <200403020001.48026.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040229212053.M47845@spots.ca> <200403020001.48026.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Open WebMail 2.30 20040103
X-OriginatingIP: 209.115.173.10 (johnp)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

Turns out I had a cable problem.  Some of the patch cables that I made, had
the wrong pinout.  After replacing them, the connection is stable at 100baseTx-FD.

Thanks

John



On Tue, 2 Mar 2004 00:01:47 +0200, Denis Vlasenko wrote
> On Sunday 29 February 2004 23:30, john wrote:
> > Hi,
> >
> > I am having problems getting a stable connection with my linux machines
> > when trying to connect them at 100 megabit speeds to a linksys etherfast
> > switch.
> >
> >
> > I have attached some diagnostic outputs for your review.  I hope that
> > someone can help me with this problem.
> >
> > I believe using a managed switch will solve the problem, but I don't want
> > to have to spend $1000.00 to fix this problem, when I should be able to
> > obtain a stable connection with the equipment I am currently using.
> 
> Try half duplex. You seldom do lots of xfers in both directions at 
> once, so half duplex is not a big loss.
> 
> Use tcpdump to see what's going on on the wire.
> --
> vda


--

