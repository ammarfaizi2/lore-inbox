Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbSKZOHk>; Tue, 26 Nov 2002 09:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266307AbSKZOHk>; Tue, 26 Nov 2002 09:07:40 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:41105 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266298AbSKZOH1>; Tue, 26 Nov 2002 09:07:27 -0500
Subject: Re: A Kernel Configuration Tale of Woe
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Dennis Grant <trog@wincom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021126105718.GG24796@fs.tum.de>
References: <3de27d7d.59a8.0@wincom.net>
	<Pine.LNX.3.95.1021125144007.806A-100000@chaos.analogic.com> 
	<20021126105718.GG24796@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 14:44:30 +0000
Message-Id: <1038321870.2658.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In his mail Dennis gave a good description of problems and missing
> features he was faced with. You might argue on a technical basis whether
> everything he suggests is implementable but his mail was very
> constructive and on-topic.

I think he missed the solution rather than missing the problem - in fact
much of the problem he reports comes from missing the real solution. The
problem though is that he's trying to solve the wrong problem. We don't
need to care about the "right kernel for box xyz" we just need to care
about "boots on box xyz".

What does that mean. Well it means you can take a pre-existing modular
everything script, set the CPU to be low enough to boot on the users
box, make the root device compiled in, make the root fs compiled in (or
use initrd as Red Hat does) and its done.


Alan

