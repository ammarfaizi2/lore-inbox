Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUCAWN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUCAWN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:13:58 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:9487 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261452AbUCAWN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:13:57 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "john" <johnp@marine-boy.nu>, Andrewm@uow.edu.au, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Problems getting a stable 100 megabit connection with linksys etherfast switch
Date: Tue, 2 Mar 2004 00:01:47 +0200
User-Agent: KMail/1.5.4
References: <20040229212053.M47845@spots.ca>
In-Reply-To: <20040229212053.M47845@spots.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403020001.48026.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 February 2004 23:30, john wrote:
> Hi,
>
> I am having problems getting a stable connection with my linux machines
> when trying to connect them at 100 megabit speeds to a linksys etherfast
> switch.
>
>
> I have attached some diagnostic outputs for your review.  I hope that
> someone can help me with this problem.
>
> I believe using a managed switch will solve the problem, but I don't want
> to have to spend $1000.00 to fix this problem, when I should be able to
> obtain a stable connection with the equipment I am currently using.

Try half duplex. You seldom do lots of xfers in both directions at once,
so half duplex is not a big loss.

Use tcpdump to see what's going on on the wire.
--
vda

