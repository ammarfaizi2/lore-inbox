Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318246AbSHMRY4>; Tue, 13 Aug 2002 13:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSHMRYz>; Tue, 13 Aug 2002 13:24:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:62859 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318246AbSHMRYE>;
	Tue, 13 Aug 2002 13:24:04 -0400
Date: Tue, 13 Aug 2002 10:24:55 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Message-ID: <1996570000.1029259495@flay>
In-Reply-To: <1029257866.20980.54.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208130937050.7411-100000@home.transmeta.com> <1029257866.20980.54.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the 2.4-ac tree it is a dynamic disable keyed off the mp 1.4 tables.
> That's how James Cleverdon (I think it was he) implemented the detection
> logic and mixed summit/sane-pc kernel build that seems to work well now

The trouble with that is that is it doesn't provide an interface for people to
disable it by hand for the many cases where constantly reprogramming 
the IO-APIC reduces the performance of their workload.

M.

