Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbULGMjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbULGMjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 07:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbULGMjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 07:39:12 -0500
Received: from mail1.slu.se ([130.238.96.11]:19678 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S261799AbULGMjI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 07:39:08 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16821.42080.932184.167780@robur.slu.se>
Date: Tue, 7 Dec 2004 13:38:56 +0100
To: Karsten Desler <kdesler@soohrt.org>
Cc: P@draigBrady.com, "David S. Miller" <davem@davemloft.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
In-Reply-To: <20041207112139.GA3610@soohrt.org>
References: <20041206205305.GA11970@soohrt.org>
	<20041206134849.498bfc93.davem@davemloft.net>
	<20041206224107.GA8529@soohrt.org>
	<41B58A58.8010007@draigBrady.com>
	<20041207112139.GA3610@soohrt.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello!

Well my experience is that it very hard not to say almost impossible to 
extrapolate idle cpu into any network system capacity. I guess this is 
what you are trying to do? 

Rather load and overload the system with traffic having the characteristics
you expect as a bonus you will get some kind proof of robustness and 
responsiveness a max load. There are tools for this type of tests.


Pádraig! Very funny... I started hacking 2 hours ago on idea I 
had for long time, This to do a light version of skb recycling based
skb->users (the pktgen trick) with very minimal kernel change..


> Anyway attached is a small patch that I used to make the e1000
> "own" the packet buffers, and hence it does not alloc/free
> per packet at all. Now this has only been tested in one
> configuration where I was just sniffing the packets, so
> definitely YMMV.

						--ro
