Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbULOC0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbULOC0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 21:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULOC0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 21:26:18 -0500
Received: from web51506.mail.yahoo.com ([206.190.38.198]:63832 "HELO
	web51506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261810AbULOC0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 21:26:08 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=aDzV3EqEzjwgFRGD4u66TZfEbanroNCfzGth27T7nNDqd4SRZN06Cir6AugH5yfU9DH0GmvEjwGpaejln6EWINM5eRs8y7YUtEXktL+9ACGBOxlD6YyNKG5WX/fzUFuEq00x0DU7+MSYYcUdpEDTm0RDEfNNbHPg3IQnf1+0+eQ=  ;
Message-ID: <20041215022607.42712.qmail@web51506.mail.yahoo.com>
Date: Tue, 14 Dec 2004 18:26:07 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: How to get the whole information dumped from kernel
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004 at 10:53, Linus Torvalds wrote:
> On Fri, 10 Dec 2004, Park Lee wrote:
> >
> > These information is the last portion of the 
> > whole information dumped from kernel on the 
> > screen. But because the machine has crashed so 
> > badly that I cann't get the whole information 
> > back.
> > Then, would you please tell me how can I get the 
> > whole information dumped from kernel when the 
> > kernel crashed? (I think that only get the whole 
> > information, Can I know what the wrong is exactly 
> > and solve it.)
>
> Several approaches:
>  - serial console ends up being very useful if you 
> do a lot of this - you can log everything to 
> another machine.
>  (And in some cases "netconsole" can be an easier 
> alternative, see 
> Documentation/networking/netconsole.txt for more 
> details).

Thanks.

I've tried to use netconsole, but it did not work very
well in my case. 
So, I want to try serial console. I have 2 computers,
one is a PC, and the other is a Laptop. Unfortunately,
my Laptop doesn't have a serial port on it. But then,
the each machine has a internal serial modem
respectively.
Then, can I use a telephone line to directly connect
the two machines via their internal modems (i.e. One
end of the telephone line is plugged into The PC's
modem, and the other end is plugged into The Laptop's
modem directly), and let them do the same function as
two serial ports and a null modem can do? If it is,
How to achieve that?

Thank you.

=====
--
Best Regards,
Park Lee

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
