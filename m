Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133067AbRECRBr>; Thu, 3 May 2001 13:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133098AbRECRBh>; Thu, 3 May 2001 13:01:37 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:32008 "HELO
	zcamail03.zca.compaq.com") by vger.kernel.org with SMTP
	id <S133067AbRECRBd>; Thu, 3 May 2001 13:01:33 -0400
Message-ID: <3AF18E38.8EA6314C@zk3.dec.com>
Date: Thu, 03 May 2001 12:58:32 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>,
        "'Andrew Morton'" <andrewm@uow.edu.au>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>
Subject: Re: [BUG] freeze Alpha ES40 SMP 2.4.4.ac3, another TCP/IP Problem ? ( 
 was 2.4.4 kernel crash , possibly tcp related )
In-Reply-To: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDD1@aeoexc1.aeo.cpqcorp.net> <20010503184610.T1162@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> On Thu, May 03, 2001 at 06:16:02PM +0200, Cabaniols, Sebastien wrote:
> > The only thing that does not work under load is the network.... TCP/IP ?
>
> My alpha is running 2.4.4aa3 under very high load (apache beaten from ab
> in loop via 100mbit switched network [tulip on the alpha] plus cerberus)
> and I didn't had any problem so far (it only deadlocked with OOM after
> one day of day of tux [instead of apache] + cerberus regression testing
> but that's only because of a memleak in tux that I reproduced on x86 too
> it seems)
>

Silly question, Sebastien - when you do a "show config" at the console, how
is your card represented?  FWIU, there have been problems with adapters under
load that aren't fully supported by SRM...  Just a guess.  Could you try this
with a DE600 (Intel) or a DE500 (tulip)?

 - Pete

