Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUCAOeL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUCAOeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:34:11 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:25798 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261278AbUCAOeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:34:02 -0500
Date: Mon, 01 Mar 2004 22:33:43 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: arjanv@redhat.com
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Micha Feigin" <michf@post.tau.ac.il>,
       "Software suspend" <swsusp-devel@lists.sourceforge.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <1ulUA-33w-3@gated-at.bofh.it>  <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>  <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th>  <20040229213302.GA23719@luna.mooo.com>  <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston>  <opr36ljbsu4evsfm@smtp.pacific.net.th> <1078141191.28288.83.camel@gaston>  <opr36ojxik4evsfm@smtp.pacific.net.th> <1078148843.4443.2.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr36tehrr4evsfm@smtp.pacific.net.th>
In-Reply-To: <1078148843.4443.2.camel@laptop.fenrus.com>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2004 14:47:23 +0100, Arjan van de Ven <arjanv@redhat.com> wrote:

>
>> Then one could just drop in a driver from 2.4 and use it.
>>
>> People having time to make new "pretty" drivers could
>> also use this facility for cross checking.
>
> I'm sorry but this is a load of bull ;)

Thank you, I do fully concur with you from an ideal scientific perspective
where resources are not constrained. Applying the same perspective I might
like to craft lots of drivers in assembler or even reinvent whatever...,
but I do not live an ideal world.

> New kernel revisions come with a new API. If we keep the old one around
> forever that achieves two things
> 1) The kernel bloats up

By a few %, only when old API is used, the benefits far outweighs the cost.

The old API should be an independent glue layer where incompatible.
Performance is not a concern here, functionality is.

> 2) Nobody puts effort into using the new (better) API

Could be fixed by the simple policy that drivers which did not exist before
must use new API.

>
> A proof of 2 is the scsi error handling; the old one was kept around as
> compat for the last 5 years and only 2 or 3 drivers bothered to use the
> new one.

I am not around here that long, but if those drivers were added after the
API was finalized, it would have been a policy issue which does not have to
be repeated.

At least, (hopefully not from an ideal perspective), the new API is good
enough to last and will not have to be trown away in 2.7 or even 2.9 :)

Regards
Michael
