Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135874AbRECRzE>; Thu, 3 May 2001 13:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135856AbRECRyG>; Thu, 3 May 2001 13:54:06 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:44559 "HELO
	zcamail04.zca.compaq.com") by vger.kernel.org with SMTP
	id <S135866AbRECRxk>; Thu, 3 May 2001 13:53:40 -0400
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDD3@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: "Rival, Frank" <FRIVAL@ZK3.DEC.COM>, Andrea Arcangeli <andrea@suse.de>
Cc: "'Andrew Morton'" <andrewm@uow.edu.au>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>
Subject: RE: [BUG] freeze Alpha ES40 SMP 2.4.4.ac3, another TCP/IP Problem
	 ? (  was 2.4.4 kernel crash , possibly tcp related )
Date: Thu, 3 May 2001 19:53:24 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrea Arcangeli wrote:
> 
> > On Thu, May 03, 2001 at 06:16:02PM +0200, Cabaniols, 
> Sebastien wrote:
> > > The only thing that does not work under load is the 
> network.... TCP/IP ?
> >
> > My alpha is running 2.4.4aa3 under very high load (apache 
> beaten from ab
> > in loop via 100mbit switched network [tulip on the alpha] 
> plus cerberus)
> > and I didn't had any problem so far (it only deadlocked 
> with OOM after
> > one day of day of tux [instead of apache] + cerberus 
> regression testing
> > but that's only because of a memleak in tux that I 
> reproduced on x86 too
> > it seems)
> >

Andrea, 


Do you think I should  install exactly the same version 2.4.4aa3 instead
of 2.4.4.ac3 with the TCP patch ? 

What else can I try to find where my bug is ?

I have DE600 boards too but from the last stress tests I did a few days ago
it was
freezing my system but I suspect this was another story, I then switched to
3com950b
because this is a very well known board and I was suspecting it could help a
lot
to standardize my system. 

I also used DE504 with the de4x5 driver and it was again crashing my system.

I did not used the tulip driver though ( :( ) 

Again, thanks a lot for any help
  

