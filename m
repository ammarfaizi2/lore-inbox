Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264841AbRGSCDV>; Wed, 18 Jul 2001 22:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264846AbRGSCDM>; Wed, 18 Jul 2001 22:03:12 -0400
Received: from web10408.mail.yahoo.com ([216.136.130.110]:63506 "HELO
	web10408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264841AbRGSCCz>; Wed, 18 Jul 2001 22:02:55 -0400
Message-ID: <20010719020259.24124.qmail@web10408.mail.yahoo.com>
Date: Thu, 19 Jul 2001 12:02:59 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010718182201.J13239@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL> wrote: > On
Wed, Jul 18, 2001 at 03:18:59PM +1000, Steve Kieu
> wrote:
> > My advice:
> > 
> > Dont use reiserfs,JFS
> > it is ok to use ext2 
> > 
> > Go journalling? use ext3 or XFS
> > 
> > I have used  all of these fs and pick up this rule
> (up
> > to now, not sure it remains right in the far 
> future)
> 
> FUD. I've been using reiserfs on quite some systems

Probably !. I said just from my computer, :-)

Reiserfs uses system resources more than others.
Perfomance is ok (not as far more or less than JFS)
but after using for a while, some mysterious things
happen ; for example, the ini file of some program is
changed wihtout any reason. For example I run mc and
make it learn all keys, and pause when executing a
command ; After reboot, sometimes all these setting
are lost, some times not. It still happen with XFS
though but never see in ext2, ext3 (now I am using)

JFS I was happy to use that when my computer is normal
power off. One time, power outage then it completely
trashed my root partition (can not recover by any
means) Have to restore from backup file and sure, let
it go for now.

I aggree Reiserfs should be stable but unfortunately
in my computer it doesn's show any good sign of
advantages than xfs or ext3. Dont mention about some
minor bug like zero log file (fixed already I hope)
but the data. Ahhh, I remember one time when I ran

pppd call myisp

pppd can not make the connection. I view the syslog
file and noticed that chat send the wrong command to
the modem. Strange, I thought as it is usually ok to
make the connection. Check the /etc/ppp/chat/myisp
file ; things seem to be normal. Ok I delete that file
and edit it again exactly what I saw in the previous
file. Run pppd call myisp; it is Ok. What do you
think?

It has not yet happen to me now, for about 2 weeks
(with ext3)

Okay may be that is FUD ; lets be like that way. I
only say from my usage.

Cheers,


> and never got any
> problem. If reiserfs wouldn't be stable, SuSE
> wouldn't have supported
> it as one of their stable filesystems for over a
> year.
> 
> 
> Erik
> 
> -- 
> J.A.K. (Erik) Mouw, Information and Communication
> Theory Group, Department
> of Electrical Engineering, Faculty of Information
> Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600
> GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email:
> J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

=====
S.KIEU

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
