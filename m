Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVI2OtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVI2OtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 10:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVI2OtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 10:49:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31723 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932171AbVI2OtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 10:49:08 -0400
Message-ID: <433BFEDB.6050505@pobox.com>
Date: Thu, 29 Sep 2005 10:48:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org> <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local> <433BFB1F.2020808@adaptec.com>
In-Reply-To: <433BFB1F.2020808@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> All the while, Linux _development_, seems to follow some kind
> "yours/mine", "gimme that/take that" kindergarten kind of way.
> The reason I'm saying this is that _every_ successful entity
> (person, corporation, etc) knows that in order to _survive_
> it needs to _quickly adapt to new things_: new technologies,
> new trends, new fads, etc.

The core problem is that a SAM-friendly path to SAS has already been 
chosen -- transport classes -- and your driver isn't following this path.

If we choose a new path every six months, we'll never arrive at the 
destination.


> Some companies are _fiercly_ trying to beat this _natural_
> course of History, into turning 180 degrees from their mindset
> every single year in order to chase the latest technology, the
> latest fad, in order to please customers and stay on top.
> 
> I wish Linux would return to its roots.

Linux today is the most successful its ever been.  This system, however 
strange it may seem, does work.


>>Hans Reiser once said that every software needs a complete rewrite
>>every 3 or 5 years (I don't precisely remember). I tend to agree
>>with him. Maybe it's time to completely rewrite the SCSI subsystem,
>>but maybe it will be too long, too risky and not worth the effort.
>>Maybe it can simply coexist with another new subsystem. This is what
> 
> 
> Now _this_ is a smart suggestion: it wouldn't break legacy hardware
> _and_ it would give Linux SCSI a fresh start.
> 
> Next year, your new serverboard wouldn't have any of those old
> cumbersome storage chips to worry about.  It would have only one
> storage chip which could do SAS and SATA and that'd be that.
> Why would anyone need this fat, old semanticaly overloaded,
> SPI-centric SCSI Core?

The rest of the Linux-SCSI devs are trying to make it less SPI-centric. 
  Rather than just complain, we're doing something about it.


> Foremost, this experience reminds other vendors that Linux
> _development_ model is _not_ en par with their Linux _deployment_
> model (i.e. for a business).
> 
> Many things are left to the whim of developers whose educational
> and technical background could be in question especially when
> your only communication with them is via email.

Background is irrelevant.  Only results matter.  Linux is a meritocracy.


> I'm not shoving my solution down the throats of LSI or James or
> Christoph.  Why?
>  - because the technologies are different,
>  - beacause I'm following a SAM model, they are not.
>  - and because I'm not changing anybody else's code but integrating
>    with it.
> 
> (Jeff, I know that on the 3rd point, you'd say "That's the problem,
> you should be improving SCSI Core", and I know that if I had been
> changing other people's code, you'd say "You should not change
> other people's code", so it's a win-win-manipulative situation
> for you.  I'm aware of that, spare your keystrokes.)

Spare me your paranoia.  I've been 100% honest with you in every email 
I've written.

You -should- change other people's code.  That's how Linux gets better.

When I chose a better path for libata's error handling, the first step 
in that process was changing the locking, and modifying almost every 
$!#$@! SCSI driver in the kernel.  Rather than forever complaining about 
an outdated SCSI layer, I stepped up and fixed things.


>>seems to matter much those days. In an ideal situation, 2.7 would
>>have been opened for a long time,
> 
> 
> Maybe things are slowing down for Linux?  Attitude?  Complacency?
> History?  Who knows?

SCSI work is speeding up.  The SCSI core has come a -long- way in the 
past couple years.  2.6.x SCSI is light years ahead of 2.4.x SCSI.

	Jeff


