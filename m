Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261827AbSJDObJ>; Fri, 4 Oct 2002 10:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261826AbSJDObJ>; Fri, 4 Oct 2002 10:31:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18304 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261827AbSJDObE>; Fri, 4 Oct 2002 10:31:04 -0400
Date: Fri, 4 Oct 2002 10:36:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christoph Hellwig <hch@infradead.org>
cc: Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
In-Reply-To: <20021004150849.A30635@infradead.org>
Message-ID: <Pine.LNX.3.95.1021004103121.452B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, Christoph Hellwig wrote:

> On Thu, Oct 03, 2002 at 12:42:23PM -0500, Mark Peloquin wrote:
> > >> +#define TRUE                            1
> > 
> > > Please just use 0/1 directly just like everyone else..
> > 
> > More than happy to comply, however grep'ing the tree its
> > plain to see that not "everyone else" is following this
> > suggestion.
> 
> Sure there are other offenders in the drivers, from known offenders like
> Richard or IBM, but no core code.  There is a reason why theses defines are
> not in kernel.h..

Is it because TRUE is not ~FALSE? or because FALSE is not ~TRUE or
is it because TRUE is not !FALSE? or because FALSE is not !TRUE?

		^;)

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

