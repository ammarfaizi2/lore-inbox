Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbTBLALR>; Tue, 11 Feb 2003 19:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbTBLALR>; Tue, 11 Feb 2003 19:11:17 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:46554 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S266959AbTBLALQ>; Tue, 11 Feb 2003 19:11:16 -0500
Message-ID: <3E499368.8070409@blue-labs.org>
Date: Tue, 11 Feb 2003 19:20:56 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Neil Brown <neilb@cse.unsw.edu.au>, Oleg Drokin <green@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Current NFS issues (2.5.59)
References: <3E46E1D6.20709@blue-labs.org>	<15944.30340.955911.798377@notabene.cse.unsw.edu.au>	<20030211100011.A5850@namesys.com>	<15944.60247.512630.175678@charged.uio.no>	<20030211163119.A24157@namesys.com>	<15945.30044.444455.162630@notabene.cse.unsw.edu.au> <15945.36788.945931.141582@charged.uio.no>
In-Reply-To: <15945.36788.945931.141582@charged.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my network, Server 2 (web server) is SMP and one client is SMP.  The 
more problematic client is not SMP.  I'll do some debugging in a moment, 
I've another fire to put out presently.

-d

Trond Myklebust wrote:

>[...]
>
>On the contrary. The above shows that the client is indeed receiving
>some data, but for some reason it is not accepting that data as a
>valid reply. It looks as if either skb_recv_datagram() or
>xprt_lookup_rqst() is failing.
>
>BTW: I'm still not seeing any such trouble with these loopback mounts
>on my own machine. Could it be an SMP problem?
>
>Cheers,
>  Trond
>  
>

