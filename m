Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVBUQPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVBUQPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 11:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVBUQPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 11:15:25 -0500
Received: from mail.nuim.ie ([149.157.1.19]:17387 "EHLO LARCH.MAY.IE")
	by vger.kernel.org with ESMTP id S262016AbVBUQPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 11:15:17 -0500
Date: Mon, 21 Feb 2005 16:15:16 +0000
From: Yee-Ting Li <Yee-Ting.Li@nuim.ie>
Subject: Re: BicTCP Implementation Bug
In-reply-to: <421A0337.6020601@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Douglas Leith <doug.leith@nuim.ie>, linux-net@vger.kernel.org,
       rhee@ncsu.edu, Yee-Ting Li <Yee-Ting.Li@nuim.ie>,
       linux-kernel@vger.kernel.org, Baruch Even <baruch@ev-en.org>,
       Les Cottrell <cottrell@slac.stanford.edu>,
       Richard Hughes-Jones <r.hughes-jones@man.ac.uk>, davem@davemloft.net
Message-id: <0d8ea68bba9feb62ffd08d085b47e48c@may.ie>
MIME-version: 1.0
X-Mailer: Apple Mail (2.619.2)
Content-type: text/plain; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
References: <fd9de42cb9cca9589da8a65bb6e719d5@may.ie>
 <421A0337.6020601@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We just wanted to be sure of the implementation against the official 
BicTCP versions and that it was a real bug.

We are particularly concerned that the deployment of these experimental 
protocols (and they're not even RFCs) are too premature and that we 
think that they should be switched OFF by default to prevent 
undesirable consequences to network stability. One concern is that such 
protocols will steal (sometimes a lot of) bandwidth from normal network 
traffic.

We wrote the paper as we (amongst others) are in the process of 
rigourously validating and testing these TCP proposals over a wide 
range of network environments There are also numerous other proposals 
around (HSTCP, ScalableTCP, HTCP, FAST etc) that we are also testing 
and we would be more than happy to provide patches (excluding FAST) and 
experimental results as they become available.

Yee.


On Feb 21, 2005, at 15:50, Stephen Hemminger wrote:

> Yes, this looks like a bug, let me verify it first.
> Why did you sit on this so long and go to all the trouble of making a 
> paper out of it?
>

