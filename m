Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVJOHiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVJOHiF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVJOHiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:38:05 -0400
Received: from web33311.mail.mud.yahoo.com ([68.142.206.126]:63662 "HELO
	web33311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751114AbVJOHiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:38:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=K7DHiqg00VtPp/F5iRdyymFyvwBV/0Me6/6HjslT4WuzdQP7YbnVJmIutRFVNhtD1AmEhJmSi9/wFT7zXTBM3Gw/8+vUCFbZOXVXq8cdELJaze+4hQlAwvcquswtXXvw6Y0IYhqmAMwPqoG+C5F1YC/J++sNrd0Q0KBoxT6oXKI=  ;
Message-ID: <20051015073803.26937.qmail@web33311.mail.mud.yahoo.com>
Date: Sat, 15 Oct 2005 00:38:03 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: lock_kernel twice possible ?
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <2cd57c900510150033o7bd44608vdc57cb32e335b933@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, couldn't get what you want to say.
Can you please elaborate.

--- Coywolf Qi Hunt <coywolf@gmail.com> wrote:

> On 10/15/05, li nux <lnxluv@yahoo.com> wrote:
> > Hi,
> >
> > I was going thru the NFS v3 code for SMP kernel
> 2.6.11
> > to see how an inode gets revalidated. I found that
> > there is a possibility that there may be an
> attempt to
> > do lock_kernel() twice.
> >
> > Is this possible ? If yes then how this deadlock
> > condition is/can be avoided.
> 
> The BKL is recursive!
> --
> Coywolf Qi Hunt
> http://sosdg.org/~coywolf/
> 



		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free.
http://music.yahoo.com/unlimited/
