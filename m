Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbRBUXOO>; Wed, 21 Feb 2001 18:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBUXOF>; Wed, 21 Feb 2001 18:14:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:5256 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129170AbRBUXNu>; Wed, 21 Feb 2001 18:13:50 -0500
Date: Wed, 21 Feb 2001 20:15:12 -0300 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: "J . A . Magallon" <jamagallon@able.es>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: swap still stuck
In-Reply-To: <20010221001406.A1035@werewolf.able.es>
Message-ID: <Pine.LNX.4.31.0102212013350.21127-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, J . A . Magallon wrote:

> I seem to have again a problem that was talked about on the
> list, but I thought it was yet corrected with some VM constants
> balancing.

> Why system does not try to drop read buffer pages before swapping ?

Actually, I've also started receiving complaints that the
system keeps processes in memory too much and evicts the
cache from memory too soon...

It all depends on what kind of workload you are using.

In the current 2.4 VM, I have not found a way to make this
balancing do the right thing automatically. If anybody has
an idea (or a patch) to make this thing work, let me know.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

