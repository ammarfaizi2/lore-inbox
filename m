Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310501AbSCGUSj>; Thu, 7 Mar 2002 15:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310504AbSCGUS3>; Thu, 7 Mar 2002 15:18:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54533 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310501AbSCGUSX>; Thu, 7 Mar 2002 15:18:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Date: 7 Mar 2002 12:17:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a68htg$bc1$1@cesium.transmeta.com>
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au> <20020307153228.3A6773FE06@smtp.linux.ibm.com> <20020307104241.D24040@devserv.devel.redhat.com> <20020307191043.9C5F33FE15@smtp.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020307191043.9C5F33FE15@smtp.linux.ibm.com>
By author:    Hubertus Franke <frankeh@watson.ibm.com>
In newsgroup: linux.dev.kernel
> 
> Take a look at Rusty's futex-1.2, the code is not that different, however
> if its all inlined it creates additional code on the critical path 
> and why do it if not necessary.
> 
> In this case the futexes are the well tested path, the rest is a cludge on
> top of it.
> 

Perhaps someone could give a high-level description of how these
"futexes" work?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
