Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTDKMHl (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 08:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTDKMHl (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 08:07:41 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:43392 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264342AbTDKMHk (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 08:07:40 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304111221.h3BCLiHv000820@81-2-122-30.bradfords.org.uk>
Subject: Re: [RFC] first try for swap prefetch
To: schlicht@uni-mannheim.de (Thomas Schlichter)
Date: Fri, 11 Apr 2003 13:21:44 +0100 (BST)
Cc: akpm@digeo.com (Andrew Morton), linux-kernel@vger.kernel.org
In-Reply-To: <200304111352.05774.schlicht@uni-mannheim.de> from "Thomas Schlichter" at Apr 11, 2003 01:51:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > as mentioned a few days ago I was going to try to implement a swap
> > > prefetch to better utilize the free memory. Now here is my first try.
> >
> > That's surprisingly cute.  Does it actually do anything noticeable?
> 
> Well, it fills free pagecache memory with swapped pages... ;-)

Actually, it could potentially do something very useful - if you are
using a laptop, or other machine where disks are spun down to save
power, you might be swapping in data while the disk still happens to
be spinning, rather than letting it spin down, then having to spin it
up again - in that instance you are definitely gaining something,
(more battery life).

John.
