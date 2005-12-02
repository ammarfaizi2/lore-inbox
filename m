Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVLBSuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVLBSuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVLBSuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:50:44 -0500
Received: from web36912.mail.mud.yahoo.com ([209.191.85.80]:32918 "HELO
	web36912.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750953AbVLBSuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:50:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jQprITHpONgHm/JC0EUBCKZUABAyBwUDes7lHQtU+O0s+6jzqRBegPRmppGzEIuQFawXP3onXHbutbfgcLcVxSfRFufusGkXVHhzFIQNjD7iXSscHvGROlyLppMiuTPTpvAvX1kLnJ45Yrk2B4xS805yDaGvMuKBRrf2I4fHps0=  ;
Message-ID: <20051202185043.91582.qmail@web36912.mail.mud.yahoo.com>
Date: Fri, 2 Dec 2005 18:50:43 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH 2.6-git] SPI core refresh
To: Vitaly Wool <vwool@ru.mvista.com>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
In-Reply-To: <438FE47A.7080100@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vitaly Wool <vwool@ru.mvista.com> wrote:

> Greg KH wrote:
> 
> >>- The character device interface was reworked
> >>    
> >>
> >
> >reworked how?
> >  
> >
> It was originally designed for 2.6.10 and now it's 2.6-git-synchronized.
> 
> >  
> >
> >>- it's more adapted for use in real-time environments
> >>    
> >>
> >
> >I still do not see why you are stating this.  Why do you say this?
> >  
> >
> Due to possible priority inversion problems in David's core.

Which you still haven't proven, in fact you now seem to be changing your mind and saying that
there might be a problem if an adapter driver was implemented badly although I still don't see how
this could happen (the priority inversion I mean not the badly implemented driver ;).

> 
> >I think you should work with David more...
> >  
> >
> P'haps you're right. I suggest re-enumerating all the differences 
> between the cores and working them out.
> However, if David's not going to accept any facts or speculations that 
> contradict his being sure his core is the best a man could ever do, 
> we're screwed. :(

When I worked with David he was very helpful. He pointed out my misconceptions and accepted my
comments that is core was missing functionality which he then added.

In fact at one time there were 3 SPI subsystems being prosposed, David's, Vitaly's and mine. David
and I work together to take the best from both which is now the solution he is proposing.

Mark

> 
> Vitaly
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
