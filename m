Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVI2RPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVI2RPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVI2RPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:15:49 -0400
Received: from ns.firmix.at ([62.141.48.66]:26772 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932267AbVI2RPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:15:48 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Bernd Petrovitsch <bernd@firmix.at>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <433C174D.4050302@adaptec.com>
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org>
	 <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local>
	 <433BFB1F.2020808@adaptec.com> <1128007032.11443.77.camel@tara.firmix.at>
	 <433C174D.4050302@adaptec.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 29 Sep 2005 19:13:27 +0200
Message-Id: <1128014007.11443.108.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 12:33 -0400, Luben Tuikov wrote:
> On 09/29/05 11:17, Bernd Petrovitsch wrote:
[...] 
> > Then submit your driver as a (separate) block device in parallel to the
> > existing SCSI subsystem. People will use it for/with other parts if it
> 
> SAS is ultimately SCSI.  I'll just have to write my own SCSI core.
> _We_ together can do this in parallel to the old SCSI Core.
>
> This is the whole idea.

The question is: Who starts and leads seriously this effort (and takes
in the course others with him)?
Just telling others where to go and waiting until they carry you there
usually doesn't succeed if you are not the boss of them (and/or they
are free to leave at any time without significant punishment).

> > makes sense (and you - as the maintainer - accept their patches). And in
[...]
> > a few years the "old" SCSI core fades out as legacy drives fade out (or
> > they will happily coexist forever).
> 
> Yep, I've been saying this since 2002.  On the linux-scsi ML.

Perhaps speaking is not enough and work should follow?
All people who really do the work like those others standing beneath
(possibly doing their own thing) and telling them how to do their own
work best.

> And this is the problem: *you* and "the community" see things in
> *this* way:  "your balls - my balls", "yours/mine".

It's at most (and actually exactly) "my work - your work", not "my balls
- your balls" (or "code" or whatever).
If you want to play "our work" (read: team[0] work), than you have to
cope with others (and they with you), their - probably historically
grown - design (even if it is wrong), etc.
If this doesn't work (and ATM I have this impression) for whatever
reason, the second step is "my work, your work".
And if two (or more) people have different design opinions (and
different opinions about "quality" and/or "correct vs wrong" - I can't
decide since I have virtually no knowledge about SCSI core internals,
discussions on the Linux-SCSI-ML, etc. to decide - not even for me -,
who is "right" and/or "wrong" in which aspect or in general), it comes
down to "better the not-so-good design and working code than the best
design and no code".
So just copy the old core, throw out what you don't want, need and/or
like and voila. If it *is* "better", it will succeed and people will
come and help.
Of course it is probably more work in the short and in the long run to
maintain a separate block driver for SAS storage, but it is at least a
possible solution.
Perhaps all relevant people will see that the difference is small enough
to converge to some point in between.

	Bernd

[0]: Not in the ironic interpretation in German which translates roughly
     to "great, another one does it".
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

