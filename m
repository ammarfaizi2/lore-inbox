Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRECSbY>; Thu, 3 May 2001 14:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRECSbO>; Thu, 3 May 2001 14:31:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27656 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130820AbRECSbG>; Thu, 3 May 2001 14:31:06 -0400
Subject: Re: [RFC] Direct Sockets Support??
To: venkateshr@ami.com
Date: Thu, 3 May 2001 19:34:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <007901c0d3fd$ea3f0880$7253e59b@megatrends.com> from "Venkatesh Ramamurthy" at May 03, 2001 02:21:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vNwL-0005z8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With the advent of VI and Infiniband, there is a growing need to support =
> Sockets over such new technologies. I studied recent performance =
> analysis of sockets vs direct sockets and found that there is a 250% =
> performance hike and 30% decrease in latency time. Also CPU bandwidth is =
> significantly reduced.=20

Define 'direct sockets' firstly.

I have seen several lines of attack on very high bandwidth devices. Firstly
the linux projects a while ago doing usermode message passing directly over
network cards for ultra low latency. Secondly there was a VI based project
that was mostly driven from userspace.

One thing that remains unresolved is the question as to whether the very low
cost Linux syscalls and zero copy are enough to achieve this using a
conventional socket API and the kernel space, or whether a hybrid direct 
access setup is actually needed.

