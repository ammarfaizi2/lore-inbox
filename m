Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSEPQsy>; Thu, 16 May 2002 12:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314442AbSEPQsx>; Thu, 16 May 2002 12:48:53 -0400
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:36065 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S314340AbSEPQsw>; Thu, 16 May 2002 12:48:52 -0400
Message-ID: <3CE3E2EF.DAEB126@uab.ericsson.se>
Date: Thu, 16 May 2002 18:48:47 +0200
From: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: knfsd misses occasional writes
In-Reply-To: <3CE250A5.47F71DF@uab.ericsson.se>
		<15586.20989.992591.474108@notabene.cse.unsw.edu.au>
		<3CE38E9D.986ACF7F@uab.ericsson.se> <15587.39544.81694.975593@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> On Thursday May 16, Sverker.Wiberg@uab.ericsson.se wrote:

[on soft mount timeouts]
> > But shouldn't those timeouts become errors over at the clients?
> 
> Yes... but "write" won't see an error.  Only 'fsync' or maybe 'close',
> and many applications ignore errors from these operations.

How come? Isn't the client side innately synchronous (as RPC clients in
general)?
Or is this one of thost thing that are now done differently?

/Sverker
