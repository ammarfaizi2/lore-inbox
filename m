Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264072AbUDVO1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbUDVO1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 10:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264084AbUDVO1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 10:27:14 -0400
Received: from mx01.cybersurf.com ([209.197.145.104]:39576 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S264072AbUDVO1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 10:27:07 -0400
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, cfriesen@nortelnetworks.com,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
In-Reply-To: <Pine.LNX.4.58.0404221532480.670@denise.shiny.it>
References: <XFMail.20040422102359.pochini@shiny.it>
	 <1082640135.1059.93.camel@jzny.localdomain>
	 <Pine.LNX.4.58.0404221532480.670@denise.shiny.it>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1082644022.1099.40.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 22 Apr 2004 10:27:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 09:46, Giuliano Pochini wrote:
> On Thu, 22 Apr 2004, jamal wrote:
> 
> > On Thu, 2004-04-22 at 04:23, Giuliano Pochini wrote:
> >
> > > Yes, but it is possible, expecially for long sessions.
> >
> > In other words, 80% or more of internet traffic would not be affected
> > still using http1.0 would not be affected.
> > And for something like a huge download to just regular joe, this is more
> > of a nuisance assuming some kiddie has access between you and the
> > server.
> 
> No, TCP/IP is 100% vulnerable to the man-in-the-middle attach.
>  There is no cure for that. 

Unless its a private network with locked vaults for the pipes, any
network is vulnerable.
I am not trying to downplay the relevance of this; all i am saying
is it may a little overhyped with the media being involved. Its
infact harder to create this attack compared to a simple SYN attack.

On Thu, 2004-04-22 at 09:58, Florian Weimer wrote:
jamal <hadi@cyberus.ca> writes:
> 
> > OTOH, long lived BGP sessions are affected assuming you are going across
> > hostile path to your peer.
> 
> Hostile path is not required.  Not at all. 8-(
> 
> 

Unless i misunderstood:
You need someone/thing to see about 64K packets within a single flow
to make the predicition so the attack is succesful. Sure to have access to
such capability is to be in a hostile path, no? ;-> 


> And it's not BGP specific.  You might be able to use this attack to
> split IRC networks, too.  However, it's a bit harder in this case
> because IRC servers usually use more random source ports.

Any long lived flow with close to fixed ports. FTP from kernel.org could
be vulnerable - get a better client and its just becomes a nuisance.
80% of the internet traffic is still TCP/HTTP1.0 which is very 
short lived (there could be changes lately - these are numbers from 
a while back) i.e you wont see more than 8 packets i.e it is highly unlikely 
your traffic there is affected even if you used fixed ports.

cheers,
jamal

