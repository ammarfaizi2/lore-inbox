Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbQKJThb>; Fri, 10 Nov 2000 14:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131500AbQKJThV>; Fri, 10 Nov 2000 14:37:21 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:12558 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131497AbQKJThK>; Fri, 10 Nov 2000 14:37:10 -0500
Message-ID: <3A0C4D6B.B4FF664C@timpanogas.org>
Date: Fri, 10 Nov 2000 12:33:00 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "William F. Maton" <wmaton@ryouko.dgim.crc.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  
 /var/spool/mqueue]
In-Reply-To: <Pine.LNX.3.95.1001110142537.5403A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Richard B. Johnson" wrote:
> 
> On Fri, 10 Nov 2000, William F. Maton wrote:
> 
> > On Fri, 10 Nov 2000, Jeff V. Merkey wrote:
> >
> > >
> > > The sendmail folks are claiming that the TCPIP stack in Linux is broken,
> > > which is what they claim is causing problems on sendmail on Linux
> > > platforms.  Before anyone says, "don't use that piece of shit sendmail,
> > > use qmail instead", perhaps we should look at this problem and refute
> > > these statements -- I think that sendmail is causing this problem.  The
> > > version is sendmail 8.9.3
> >
> > What about sendmail 8.11.1?  Is the problem there too?
> >
> 
> I am running sendmail-8.11-0.Beta3 on Linux 2.4.0-test9. I didn't
> have any problem with it (except that the documentation sucks,
> making it extremely difficult to configure). Once configured, it runs
> fine. It also ran fine on Linux-2.2.17.
> 
> If something is staying in the mail-queue `mailq`, this means that
> the daemon isn't running. It may have crashed. This can be caused
> by somebody keeping some mailer entry in /etc/inetd.conf. Sendmail
> has to run as a daemon with no other interference on port 25.
> Check the configuration.

I did Dick.  The config is fine.  The daemon is also fine and running. 
What's really weird is that even if I do a "sendmail -v -q" command
(which should force the queue to flush) it still doesn't. 

Jeff

> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
