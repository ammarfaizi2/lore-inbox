Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSFQWwP>; Mon, 17 Jun 2002 18:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317119AbSFQWwP>; Mon, 17 Jun 2002 18:52:15 -0400
Received: from monster.nni.com ([216.107.0.51]:19204 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S317117AbSFQWwN>;
	Mon, 17 Jun 2002 18:52:13 -0400
Date: Mon, 17 Jun 2002 18:50:34 -0400
From: Andrew Rodland <arodland@noln.com>
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: invalidate: busy buffer
Message-Id: <20020617185034.2a91d427.arodland@noln.com>
In-Reply-To: <1024353974.32508.4.camel@slurv.tomt.lan>
References: <000701c2164c$65630930$0501a8c0@Stev.org>
	<20020617182137.5158103f.arodland@noln.com>
	<1024353974.32508.4.camel@slurv.tomt.lan>
X-Mailer: Sylpheed version 0.7.6claws16 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2002 00:46:14 +0200
Andre Tomt <andre@tomt.net> wrote:

> On Tue, 2002-06-18 at 00:21, Andrew Rodland wrote:
> > On Mon, 17 Jun 2002 23:14:48 +0100
> > "James Stevenson" <mistral@stev.org> wrote:
> > 
> > Something tried to wipe out all of the caches for some device, but
> > something else was using it at the time. For example, if you try to
> > run parted on something mounted (and bypass/confuse its mountedness
> > check) you'll see this. Were you doing anything like that?
> 
> or run for example hdparm -tT device to do a (imho pretty useless)
> "benchmark" of io throughput.
> 
> -- 
> André Tomt
> andre@tomt.net
> 

the first half of hdparm -Tt is useful as a benchmark of how quick other
parts of the kernel are, though... changing the optimization level, or
the difference between vanilla and rmap, non-preempt and preempt, etc,
affects this a good bit. :)
