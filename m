Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbTAPUTu>; Thu, 16 Jan 2003 15:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTAPUTt>; Thu, 16 Jan 2003 15:19:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47627 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267228AbTAPUTt>; Thu, 16 Jan 2003 15:19:49 -0500
Date: Thu, 16 Jan 2003 12:28:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/3) NUMA aware scheduler
In-Reply-To: <2050000.1042741643@flay>
Message-ID: <Pine.LNX.4.44.0301161225260.1175-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied. 

I also have to say that I hope this means that the HT-specific scheduler 
stuff will go away. HT _should_ be just another NuMA issue, and right now 
the two seem to be just slightly different ways of covering the same 
needs.

However, I'm going away for two weeks starting tomorrow, so even if there 
is some experimental HT/NUMA patch, I don't want it at this point. The 
NUMA scheduler merge is more of a "get the infrastructure in place" thing 
for me right now.

			Linus

