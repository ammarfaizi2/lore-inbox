Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSHMU3Z>; Tue, 13 Aug 2002 16:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319080AbSHMU3Z>; Tue, 13 Aug 2002 16:29:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53767 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317931AbSHMU3Y>; Tue, 13 Aug 2002 16:29:24 -0400
Date: Tue, 13 Aug 2002 13:35:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <1029270175.20975.103.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208131332440.1265-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Aug 2002, Alan Cox wrote:
> 
> On a collection of networking workloads the P4 is about 5% better
> performing with the irq balancer off.

Hmm. And I could _feel_ how my dual HT P4 was slow before the irq issues 
were fixed.

Now, there have been other changes too - like the scheduler (and my
current P4 has a different SCSI interface), but I dunno. The thing I 
attributed the improvements in interactive feel was the fact that the work 
got balanced out more sanely.

		Linus

