Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265474AbUEZKkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbUEZKkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265447AbUEZKkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:40:11 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:17024 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265474AbUEZKjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:39:36 -0400
Date: Wed, 26 May 2004 11:46:06 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405261046.i4QAk6BD000856@81-2-122-30.bradfords.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Buddy Lumpkin <b.lumpkin@comcast.net>,
       "'William Lee Irwin III'" <wli@holomorphy.com>, orders@nodivisions.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <40B467DA.4070600@yahoo.com.au>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
 <40B4590A.1090006@yahoo.com.au>
 <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk>
 <40B467DA.4070600@yahoo.com.au>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Nick Piggin <nickpiggin@yahoo.com.au>:
> John Bradford wrote:
> > Quote from Nick Piggin <nickpiggin@yahoo.com.au>:
> > 
> >>Even for systems that don't *need* the extra memory space, swap can
> >>actually provide performance improvements by allowing unused memory
> >>to be replaced with often-used memory.
> > 
> > 
> > That's true, but it's not a magical property of swap space - extra physical
> > RAM would do more or less the same thing.
> > 
> 
> Well it is a magical property of swap space, because extra RAM
> doesn't allow you to replace unused memory with often used memory.

Strictly speaking no, but instead of replacing unused memory with often used
memory, the often used memory has it's own silicon, so the unused memory can
stay paged in as well.

Or to put it another way, however much swap a machine has, installing that
much extra physical RAM, and removing the swap space will almost never cause
a loss in performance.  There are some theoretical cases where it would,
such as where adding extra physical RAM requires the use of different memory
addressing schemes, and some data which would have, by chance, resided in
more quickly accessible RAM before the upgrade no longer does, but those
scenarios are not really anything to do with the original discussion.

John.
