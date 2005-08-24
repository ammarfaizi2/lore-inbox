Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVHXQdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVHXQdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVHXQdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:33:20 -0400
Received: from web33305.mail.mud.yahoo.com ([68.142.206.120]:44978 "HELO
	web33305.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751142AbVHXQdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:33:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fWmOpu6RMnULgLDj2nJ1uU4on7asxhgUAttc4u0/my09o9WEap6nTzl2sjxYP90CNqt1zfIhWesnIgwMKRSzMswe6qg+1jFAB9cEV8iFYKeOi+ya3rLyXvNgtSPKr13Hdd2FB9nbofu/Ia67uOePTYo79a+JeA/KxKlh4loeU1Y=  ;
Message-ID: <20050824163315.96541.qmail@web33305.mail.mud.yahoo.com>
Date: Wed, 24 Aug 2005 09:33:15 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Sven-Thorsten Dietrich <sven@mvista.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1124828536.15265.160.camel@imap.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Sven-Thorsten Dietrich <sven@mvista.com>
wrote:

> On Tue, 2005-08-23 at 13:10 -0700, Danial Thom
> wrote:
> > 
> > None of this is helpful, but since no one has
> > been able to tell me how to tune it to
> provide
> > absolute priority to the network stack I'll
> > assume it can't be done.
> 
> History has proven that camp wrong almost 100%
> of the time.
> 
> You were told to turn off kernel preemption. 
> 
> A diligent comparison requires that, since 2.4
> does not support kernel
> preemption, and a fair comparison requires
> holding all other things
> constant.
> 
> In addition, there were several IP-level
> features mentioned in emails,
> that have been added to 2.6.
> 
> You need to make sure those are all off by
> default, to keep your
> comparison relevant.
> 
> All the answers are before you, review those
> emails, turn all that stuff
> off and retest.

I had tried turning off pre-emption, with little
difference. However linux had the same properties
before there was such a setting (of liking to
drop packets here and there for no apparent
reason under heavy load), so I didn't expect it
to make a huge difference. It seems typing on the
keyboard has the same effect with or without
pre-emption enabled. 

IP is not involved in this test, so no IP stack
issues should be relevent.

Danial



		
__________________________________ 
Yahoo! Mail for Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
