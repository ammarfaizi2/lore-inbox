Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbVIRKV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVIRKV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 06:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVIRKV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 06:21:57 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:65187 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750871AbVIRKV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 06:21:57 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: chriswhite@gentoo.org
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Date: Sun, 18 Sep 2005 13:21:23 +0300
User-Agent: KMail/1.8.2
Cc: Christoph Hellwig <hch@infradead.org>, Hans Reiser <reiser@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com> <200509171415.50454.vda@ilport.com.ua> <200509180934.50789.chriswhite@gentoo.org>
In-Reply-To: <200509180934.50789.chriswhite@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509181321.23211.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 September 2005 03:34, Chris White wrote:
> CC-List trimmed
> 
> On Saturday 17 September 2005 20:15, Denis Vlasenko wrote:
> > > At least reiser4 is smaller. IIRC xfs is older than reiser4 and had more
> > > time to optimize code size, but:
> > >
> > > reiser4        2557872 bytes
> > > xfs            3306782 bytes
> >
> > And modules sizes:
> >
> > reiser4.ko        442012 bytes
> > xfs.ko            494337 bytes
> 
> All this is fine and dandy, but saying "My code is better than yours!!" still 
> doesn't solve the issue this thread hopes to achieve, that being "I'd like to 
> get reiser4 into the kernel".  There seems to be a lot of (historical?) 
> tension present here, but all that seems to be doing is making things worse.  
> PLEASE keep this thing a tad on par.  Keeping this up is hurting everyone 
> more than helping.  I wish I could say something as simple as "let's just be 
> friends", but that's saying a lot.  I can say this though: this is open 
> source, and that means that our source is open, and we should be too.

I am trying to say that I think that Hans is being treated a bit unfairly.
His fs is new and has fairly complex on-disk structure and complex journalling
machinery, yet his source and object code is smaller than xfs which already
is accepted. This is no easy feat I guess.

Maybe xfs shouldn't be accepted too, this may be an answer.

Let's look at the code. Hans' code is not _that_ awful. Yet people
(not all of them, but some) do not point to specific things which they
want to be fixed/improved. I see blanket arguments like "your code is hard
to read". Well. Maybe spend a minute on what exactly is hard to read,
or do we require Hans to be able to read minds from the distance?

This is it. I do not say "accept reiser4 NOW", I am saying "give Hans
good code review".
--
vda
