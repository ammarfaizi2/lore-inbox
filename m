Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292923AbSB0Ud5>; Wed, 27 Feb 2002 15:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292938AbSB0Ubd>; Wed, 27 Feb 2002 15:31:33 -0500
Received: from web12305.mail.yahoo.com ([216.136.173.103]:48657 "HELO
	web12305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292941AbSB0UbI>; Wed, 27 Feb 2002 15:31:08 -0500
Message-ID: <20020227203101.78001.qmail@web12305.mail.yahoo.com>
Date: Wed, 27 Feb 2002 12:31:01 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: Re: Fw: memory corruption in tcp bind hash buckets on SMP?
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, raghuangadi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <200202272012.XAA10411@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > inverted order of insertion into the lists in tw_hashdance() is probably
> > cleaner fix than inverted order of removal.. 
> 
> Why are they not equivalent? Good question? :-)

they are. with "if (!tb->tb) return;" instead of "if (!tb->pprev) return;".
silly me was thinking of literal cut-n-paste invertion of the oder :->

> Alexey


__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com
