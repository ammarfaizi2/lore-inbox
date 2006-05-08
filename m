Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWEHRZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWEHRZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWEHRZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:25:48 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:22048 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932493AbWEHRZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:25:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jBXk4WS0K1kwSTR6T8RyZTo7WpMTT2siX1DmSwUyNa51/25zuYKzPvBYSQLKwFEUVag1imzllcQxWKnCCSbiDmGVnRKxzZOVEje81naPdB2eGi6RcDYqBJbTkAGKOANLiHu19AgPCjE/pO2cFBioaJ+HlZTTJT67AkzpuzPUSrc=
Message-ID: <3feffd230605081025t6fa078abm5c610b9a597a1ca@mail.gmail.com>
Date: Tue, 9 May 2006 01:25:45 +0800
From: "Wong Edison" <hswong3i@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH] TCP congestion module: add TCP-LP supporting for 2.6.16.14
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060508112915.GB4162@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3feffd230605062232m1b9a3951h6d21071cdacc890f@mail.gmail.com>
	 <20060508112915.GB4162@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

umum...
as i am new in submitting patch...
althought i have already read for a lot of reference...
i know only a little about the format required :(

i would like to do whatever i need to do
may u give me some hints about how to do so ??

net-nice -n 19 rsync ??
sorry that i don't know what is it... :(

for how to use it
1. patch the source tree
2. chose TCP-LP as modules and make it
3. after install use:
  sysctl -w net.ipv4.tcp_congestion_control=lp
4. you will then find your connection is relatively lower priority
than other computers

i put my work in my site:
http://edin.no-ip.com/project/tcp-lp/

Regard,
Edison

2006/5/8, Pavel Machek <pavel@suse.cz>:
> Hi!
>
> > TCP Low Priority is a distributed algorithm whose goal
> > is to utilize only
> > the excess network bandwidth as compared to the ``fair
> > share`` of
> > bandwidth as targeted by TCP. Available from:
> >   http://www.ece.rice.edu/~akuzma/Doc/akuzma/TCP-LP.pdf
>
> Nice... I'd like to use something like this on my (overloaded)
> GPRS/EDGE link.
>
> Unfortunately, patch does not include documentation update AFAICS. How
> do I use it? net-nice -n 19 rsync would be nice, but I guess that
> would be quite complex...?
>                                                         Pavel
> --
> Thanks for all the (sleeping) penguins.
>
