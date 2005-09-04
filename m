Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVIDRLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVIDRLk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVIDRLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:11:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:19413 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932069AbVIDRLj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:11:39 -0400
Date: Sun, 4 Sep 2005 18:11:34 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org,
       vda@ilport.com.ua
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050904171134.GB9759@gallifrey>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <431B2ACE.8030806@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431B2ACE.8030806@stesmi.com>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3 (i686)
X-Uptime: 18:09:07 up 2 days,  5:35, 35 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Smietanowski (stesmi@stesmi.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Alex Davis wrote:
> >>Please don't tell me to "care for closed-source drivers". 
> > 
> > ndiswrapper is NOT closed source. And I'm not asking you to "care".
> 
> While ndiswrapper might not be closed source, I would not call the
> windows driver it loads open source ...

Would it be possible for ndiswrapper to provide a seperate stack
to the windows code so this problem is seperable?

How debuggable is stack overrun? I mean if I am the unlucky
admin who decides to setup a crypto/raid/stripe/thing setup
which runs out of stack somewhere how easy will it be
for someone who doesn't know the innards to know what
happened as opposed to running into a random oops?

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
