Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRJOOFd>; Mon, 15 Oct 2001 10:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277540AbRJOOFN>; Mon, 15 Oct 2001 10:05:13 -0400
Received: from samar.sasken.com ([164.164.56.2]:62638 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S277533AbRJOOFI>;
	Mon, 15 Oct 2001 10:05:08 -0400
From: "Shiva Raman Pandey" <shiva@sasken.com>
Subject: Netfilter  and Dynamics Mobile IP
Date: Mon, 15 Oct 2001 19:36:50 +0530
Message-ID: <9qeqf7$brv$1@ncc-z.sasken.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
My testbed configurations are :-
1. Linux Kernel - 2.4.9
2. Dynamics Mobile IP 0.7.5
3. Netfilter (iptables 1.2.3)
I am able to grab IP packets using Netfilter. I tried with ping, telnet
commands, and I am able to get the packet without any problem.

Now I am trying to grab all mobile IP control messages and packets using
Netfilter.
Commands I used are : (on the PC running as Home Agent)
iptables -A OUTPUT -p icmp -j QUEUE
dynhad --fg --debug

The Dynhad tool is displaying lots of agent adv. messages being sent, even
my Mobile Node is also getting them, but Netfilter is not getting any of the
message?
I am not able to understand why it is happening?

Please help me by answering these questions in the above context as soon as
possible
1. Why Netfilter is not getting the packets?
2. What should I do to get all the MIP packets?

Waiting for your earliest reply

Thanks and warm regards
Shiva



