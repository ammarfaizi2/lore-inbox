Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319062AbSHMSOQ>; Tue, 13 Aug 2002 14:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319061AbSHMSOQ>; Tue, 13 Aug 2002 14:14:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10254 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319062AbSHMSOP>; Tue, 13 Aug 2002 14:14:15 -0400
Date: Tue, 13 Aug 2002 11:20:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <2000630000.1029261767@flay>
Message-ID: <Pine.LNX.4.44.0208131117190.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Martin J. Bligh wrote:
> 
> I know, but you pays your money, you choose your breakage ;-)

Well, in this case, it is _you_ who end up having to choose your breakage.

> Forcing it on for every machine just because P4s are borked sounds wrong.

THAT IS NOT WHAT I SAID. Go back and read it. I said that since the P4
needs it, you don't have the choice of just ignoring it. Especially since
there are about a million more P4's out there than NUMA-Q machines.

It needs to be dynamic, not "disable it".

		Linus

