Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275195AbRJAQDB>; Mon, 1 Oct 2001 12:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275183AbRJAQCv>; Mon, 1 Oct 2001 12:02:51 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:42746 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275195AbRJAQCk>; Mon, 1 Oct 2001 12:02:40 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 1 Oct 2001 10:03:02 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] netconsole-2.4.10-B1
Message-ID: <20011001100302.B22725@turbolinux.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BB693AC.6E2DB9F4@canit.se> <Pine.LNX.4.33L.0109300448210.19147-100000@imladris.rielhome.conectiva> <9p9ai4$qgh$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9p9ai4$qgh$1@forge.intermeta.de>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 01, 2001  08:47 +0000, Henning P. Schmiedehausen wrote:
> netconsole listener offers the "receive console messages" service -> server
> netconsole.o uses the "receive console message" service -> client
> 
> So both definitions are right/wrong. Choose any you like. Just
> document it and stick to it. =:-) 

It is ironic that the most popular thread about netconsole is a foolish
semantic argument, instead of a steady stream of patches for the various
network cards.

> I am happy to have a network console no matter what is the client and
> what is the server.

I agree.  I was actually thinking just now that I would "enhance" the
netconsole-server script so that:

1) it can start both the client and the server (I will just call it
   "netconsole", and use a config file to get the settings).  Maybe
   options like "--send" and "--receive" are unambiguous enough?
2) we don't need to specify the IP address of the local host for the
   "client" (possibly enhancing the client to listen on all configured
   interfaces by default.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

