Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSDOLcb>; Mon, 15 Apr 2002 07:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312381AbSDOLca>; Mon, 15 Apr 2002 07:32:30 -0400
Received: from mustard.heime.net ([194.234.65.222]:15267 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S312279AbSDOLca>; Mon, 15 Apr 2002 07:32:30 -0400
Date: Mon, 15 Apr 2002 13:30:08 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: ivan <ivan@es.usyd.edu.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Memory Leaking. Help!
In-Reply-To: <Pine.LNX.4.33.0204150848340.20787-100000@dipole.es.usyd.edu.au>
Message-ID: <Pine.LNX.4.44.0204151329030.24403-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 10 Days ago I installed DNS and DHCPd servers from RedHat and noticed that 
> > > "top" shows the amount of consumed memory is slowly and constantly 
> > > growing. Machine became unstable and a few users complained that their 
> > > files disappeared. ( we have good backup ). I re-booted 4 days ago and now 
> > > it looks it is doing it again. Could this be BIND?
> > 
> > Wildly improbable. Slow shifts in memory usage occur naturally so don't be 
> > totally mislead by it. Named for example will grow and shrink over time 
> > according to what it has cached and what people asked for.
> 
> But it took half of my swap (4GB) as well. A bit too much 
> for a little bind. How to explain this?
> 

Bind can be greedy on memory usage. Upgrade to 9.2.0, and set 
max-cache-size to limit it :-)

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

