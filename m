Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316078AbSEORnJ>; Wed, 15 May 2002 13:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316450AbSEORnI>; Wed, 15 May 2002 13:43:08 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:5642 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316078AbSEORnH>;
	Wed, 15 May 2002 13:43:07 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205151743.g4FHh2922978@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: From "(env:" "ptb)" at "May 15, 2002 06:01:35 pm"
To: steve@gw.chygwyn.com, alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com,
        kumbera@yahoo.com
Date: Wed, 15 May 2002 19:43:02 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>, steve@gw.chygwyn.com,
        alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com, kumbera@yahoo.com
Reply-To: guk.ukuu.org.uk@it.uc3m.es, chen_xiangping@emc.com,
        kumbera@yahoo.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago ptb wrote:"
> There are also several studies being made from collaborators in
> Heidelberg which show qualitative differences between new VM and old VM
> behaviour on the _server_ side.  Basically, put an old VM on the server,
> and push data to it with VM, and you get something like a steady
> 16.5MB/s.  Put a new VM in and you get pulsed behaviour.  Maybe 18.5MB/s
> tops, dropping to nothing, then picking up again, at maybe 7s intervals.

I'll just let you know (in secret) one of the graphs that Arne sent me
today ...

  http://web.kip.uni-heidelberg.de/~wiebalck/results/plots/disk_net_GbE.pdf

I don't know the details of this experiment, but it's a push of data
over the Giga-net through ENBD to a server with a modern VM. I think
the timing on the server graph is slightly shifted .. I believe it's
been shown in other experiments that the server disk i/o blocks first,
and then the network backs up afterwards.



Peter
