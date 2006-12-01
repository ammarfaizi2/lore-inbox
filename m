Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030625AbWLAJHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030625AbWLAJHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967576AbWLAJHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:07:06 -0500
Received: from web59207.mail.re1.yahoo.com ([66.196.101.33]:22709 "HELO
	web59207.mail.re1.yahoo.com") by vger.kernel.org with SMTP
	id S967572AbWLAJHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:07:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=1neiFmpQVh2hAAbxbaURxtDe1AwR/OA+BfFP53ZMfTRpK3mxfC8qCtXwA4BiUwwuXQtIr3sbEZWIAUxYGyKYZhtxXshcSK0P5eJO+9nf91cH8Nyoocx2g/Oj12FPi1enKWwv8xtGyP59tWs/iVYYhC5dSOKcGTRA++3lGz9K3rs=;
X-YMail-OSG: D0Vr4p0VM1kB0v3Zx874EtHNLu7ViOofoHAgrjh6jQ.VbP_EqP71X8jkNNXY1nSVd0jJ5gM8p.YBo6LtaysDM5VyT3qFuKIjLFPg8cApsZrpv3E5NFUzmxpZ5Jng8lZgE98tcXY18C39gOx4ZA9f67PhGSSM_H5vBg--
Date: Fri, 1 Dec 2006 01:07:04 -0800 (PST)
From: tike64 <tike64@yahoo.com>
Subject: Re: realtime-preempt and arm
To: junjiec@gmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <456eff57.0e1fcf5c.617c.44a6@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <304269.38734.qm@web59207.mail.re1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> Without the support of High Resolution Timer
> supported, the timer resolution wouldn't change.

Ok, I understand that. I was not expecting more
resolution. I expected only that I would get more
precise 10ms delays. What confuses me is that the
delays roughly doubled.

> With high-resolution-timer supported, our
> arm926-based board could get resolution like
40~50us.
> There are codes you can reference ,may be you should
> just try to implement it.

It is good to know that the problem is not the arm
architecture itself. Thanks to you for that.

The problem must be in the lh7a40x specific code or my
configuration. I am not yet convinced enough that high
resolution timer implementation would solve the
problem. I don't need timing resolution finer than
10ms providing that FB doesn't blow it up to 60ms.

Could you or someone please give a hint where to look
next or give an explanation why the lack of high
resolution timer would behave like that.

--

tike



 
____________________________________________________________________________________
Cheap talk?
Check out Yahoo! Messenger's low PC-to-Phone call rates.
http://voice.yahoo.com
