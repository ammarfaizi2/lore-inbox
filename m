Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWHADr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWHADr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWHADr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:47:27 -0400
Received: from web51311.mail.yahoo.com ([206.190.39.118]:7826 "HELO
	web51311.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932244AbWHADr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:47:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=166Fm3IgHigjBvqzu/AliRmXTxCwQcdqdOrQzPTzIr1DQ7fUslwjRaQyV9v4NE0w2owJWYyNijDrzTf9vKEslScJ7CEverkxLxiR/+8mdqAsfN8RU+INgUAn/AFFCWp/lP0o1x0t47QxNiv6svGax9qDGfvZYklQSxIhkMkkSls=  ;
Message-ID: <20060801034726.58097.qmail@web51311.mail.yahoo.com>
Date: Mon, 31 Jul 2006 20:47:26 -0700 (PDT)
From: Timothy Webster <tdwebste2@yahoo.com>
Reply-To: tdwebste2@yahoo.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
To: Theodore Tso <tytso@mit.edu>, David Masover <ninja@slaphack.com>
Cc: Nate Diller <nate.diller@gmail.com>, David Lang <dlang@digitalinsight.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20060801030005.GA1987@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Different users have different needs.

I agree, there are many users who can not afford any
downtime.

I worked at the NYSE and they reboot all their
computers once a week. We had a policy at NYSE. If
you suspect a computer has hardware problems, take it
off line. It is better to be short a few computers
then have that computer bring everything down. And fix
that computer off line. Until last year I worked at
world wide webmail provider. And trust me they could
not avoid downtime. But the fact is everyone has down
time, because hardware breaks and software is broken.

However on the other hand if I am using a filesystem
for recording TV programs or to play home computer
games. Downtime is not the problem I really care
about. I am rebooting lots anyway.

The problem I see is managing disk errors. NOT
repackers, unless ofcourse I need to run it all the
time just to keep the filesystem in a usable state.

The question is why not include lots of new
filesystems. reiser4, ZFS
They both have their own markets. And perhaps a
really good clustering filesystem for markets that
require NO downtime. 

-Tim



--- Theodore Tso <tytso@mit.edu> wrote:

> On Mon, Jul 31, 2006 at 08:31:32PM -0500, David
> Masover wrote:
> > So you use a repacker.  Nice thing about a
> repacker is, everyone has 
> > downtime.  Better to plan to be a little sluggish
> when you'll have 
> > 1/10th or 1/50th of the users than be MUCH slower
> all the time.
> 
> Actually, that's a problem with log-structured
> filesystems in general.
> There are quite a few real-life workloads where you
> *don't* have
> downtime.  The thing is, in a global economy, you


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
