Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbTFCCPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 22:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbTFCCPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 22:15:40 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:34464 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264895AbTFCCPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 22:15:39 -0400
Date: Mon, 2 Jun 2003 19:28:59 -0700
From: Larry McVoy <lm@bitmover.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: BKCVS issue
Message-ID: <20030603022859.GA26322@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Aaron Lehmann <aaronl@vitelus.com>, Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <20030602211436.GF14878@vitelus.com> <200306021937.03013.rob@landley.net> <20030603003739.GG14878@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603003739.GG14878@vitelus.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.6,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 05:37:39PM -0700, Aaron Lehmann wrote:
> On Mon, Jun 02, 2003 at 07:37:02PM -0400, Rob Landley wrote:
> > On Monday 02 June 2003 17:14, Aaron Lehmann wrote:
> > > For the past few days, it seems like every time something changes in
> > > BK, the bkcvs repository has all of its files touched. At least, all
> > > files in the repository have a P preceding their names on a cvs up.
> > >
> > > It's not intolerable, but I was wondering if anyone's aware of it.
> > 
> > CVS thinks of changes as having been applied in a certain order, with each 
> > cange applying to the result of previous changes.
> 
> I understand that they are built on different models, but I had
> thought the bk->cvs translator was somewhat intelligent. I had never
> seen all the files in the CVS repository touched until a few days ago.

It is intelligent but it is busted, believe me, I know.  The conversion
happens on my desktop and it thrashes the hell out of the disk when
CVS tags.

We're swamped working on a BK release, that's our first priority.  As soon
as I get a breather I'll get back to the bk2cvs convertoer.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
