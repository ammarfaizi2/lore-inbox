Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264999AbSKANBW>; Fri, 1 Nov 2002 08:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSKANBW>; Fri, 1 Nov 2002 08:01:22 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:15239 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264999AbSKANBU>; Fri, 1 Nov 2002 08:01:20 -0500
Subject: Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.3.96.1021101012947.23822C-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021101012947.23822C-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 13:26:44 +0000
Message-Id: <1036157204.12693.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 06:34, Bill Davidsen wrote:
>   From the standpoint of just the driver that's true. However, the remote
> machine and all the network bits between them are a string of single
> points of failure. Isn't it good that both disk and network can be
> supported.

My concerns are solely with things like the correctness of the disk
dumper. Its obviously a good way to do a lot more damage if it isnt done
carefully. Quite clearly your dump system wants to support multiple dump
targets so you can dump to pci battery backed ram, down the parallel
port to an analysing box etc

