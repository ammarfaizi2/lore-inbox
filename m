Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbUBKQob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUBKQob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:44:31 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:17539 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265921AbUBKQoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:44:25 -0500
Message-ID: <402A5BE7.583D9D68@namesys.com>
Date: Wed, 11 Feb 2004 19:44:23 +0300
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: sander@humilis.net, Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiserfs for bkbits.net?
References: <200402111523.i1BFNnOq020225@work.bitmover.com> <20040211161358.GA11564@favonius>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
> 
> Larry McVoy wrote (ao):
> > We're moving openlogging back to our offices and I'm experimenting
> > with filesystems to see what gives the best performance for BK usage.
> > Reiserfs looks pretty good and I'm wondering if anyone knows any
> > reasons that we shouldn't use it for bkbits.net. Also, would it help
> > if the journal was on a different disk?

Not much if you mean performance: here is results for standard journal vs
journal relocated to NVRAM, everything in data logging journal mode:
http://thebsh.namesys.com/benchmarks/journal_relocation_to_NVRAM.html
Edward.

 Most of the bkbits traffic is
> > read so I doubt it.
> >
> > Please cc me, I'm not on the list.
> 
> I've cc'ed the Reiserfs mailinglist.
> 
> IME Reiserfs is a fast and stable fs. If you have the time to benchmark
> ext3, reiserfs, jfs and xfs (and ..) with bk then you would know first
> hand which fs is best for you. It might be worth the time.
> 
> With kind regards, Sander
> 
> --
> Humilis IT Services and Solutions
> http://www.humilis.net
