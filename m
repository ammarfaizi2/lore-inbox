Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTIXOSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 10:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTIXOSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 10:18:10 -0400
Received: from aloggw.analogic.com ([204.178.40.2]:62728 "EHLO
	aloggw.analogic.com") by vger.kernel.org with ESMTP id S261376AbTIXOSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 10:18:05 -0400
From: "Richard B. Johnson" <johnson@quark.analogic.com>
Reply-To: "Johnson, Richard" <rjohnson@analogic.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Johnson, Richard" <rjohnson@analogic.com>, linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2003 10:18:52 -0400 (EDT)
Subject: Re: Horiffic SPAM
In-Reply-To: <20030923183648.GE1269@velociraptor.random>
Message-ID: <Pine.LNX.4.53.0309241006500.30216@quark.analogic.com>
References: <Pine.LNX.4.53.0309231408260.28457@quark.analogic.com>
 <20030923183648.GE1269@velociraptor.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003, Andrea Arcangeli wrote:

> On Tue, Sep 23, 2003 at 02:11:59PM -0400, Richard B. Johnson wrote:
> > Hello all,
> >
> > I took root@chaos.analogic.com off the linux-kernel list
> > for a few days so I can trap the spammers and write their
> > addresses to `ipchains`. I have been getting approximately
> > 12,000 email messages per day on that system, making it
> > impossible to use. It's all about the servers spreading
> > the M$ email virus with the phony message to update to the
>
> the baesyan algorithm learnt about them pretty quickly, so they don't
> hurt me anymore (besides some wasted bandwidth).
>
> I doubt answerning those messages will do any good besides generating
> more traffic, but I don't know the detail of the virus so I could be
> wrong.
>

Well it seems that fire-walling the SPAM servers is *not* a good idea.
They are persistant, gang up, and will not give up until they are
able to deliver the mail! When I firewall them, my network traffic
ends up being continuous SYN floods as every spam-server in the
country tries to connect. It doesn't do any good to set `ipchains` to
REJECT instead of DENY. They just keep on banging on the door.

This morning, there was too much traffic on our T3 link to use
a Web crawler, so I had to un-firewall my machine to get about
100,000 (maybe more) mail messages delivered and thrown away.
Procmail is throwing away everything as fast as it can. The
hard-disk LEDs are on continuously, and it takes about 20
seconds to log in. The machine has been eating SPAM mail since
7:00 this morning and it's now 10:15. Maybe, eventually, I
will be able to use my machine again.

To give you a hint of the size of the problem, my /var/log/messages
which logs sendmail activity is about 12 Gb in length. I truncated
it to zero this morning.

Richard B. Johnson
Project Engineer
Analogic Corporation
Penguin : Linux version 2.2.20 on an i586 machine (330.14 BogoMips).
