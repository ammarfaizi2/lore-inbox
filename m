Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTDDRN7 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTDDREu (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:04:50 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5504 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263845AbTDDQxZ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 11:53:25 -0500
From: John Bradford <root@81-2-122-30.bradfords.org.uk>
Message-Id: <200304041706.h34H6YQ3000160@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] only use 48-bit lba when necessary
To: axboe@suse.de (Jens Axboe)
Date: Fri, 4 Apr 2003 18:06:34 +0100 (BST)
Cc: quintela@mandrakesoft.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <20030404155457.GA16144@suse.de> from "Jens Axboe" at Apr 04, 2003 05:54:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Reason is that:
> > 
> > if (expr)
> >    var = true;
> > else
> >    var = false;
> > 
> > is always a bad construct.
> >
> > var = expr;
> > 
> > is a better construct to express that meaning.
> > 
> > And yes, your is a variation of the same theme:
> > 
> > var = false;
> > if (expr)
> >    var = true;
> 
> Yes, but mine is more readable. IMO of course, that's the way it is with
> styles.

if (!expr || expr) var=(!expr ? !expr : expr);

:-)

John.
