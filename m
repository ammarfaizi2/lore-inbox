Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUFAI1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUFAI1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 04:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbUFAI1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 04:27:08 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264934AbUFAI1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 04:27:05 -0400
Date: Tue, 1 Jun 2004 09:34:01 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406010834.i518Y1cT000414@81-2-122-30.bradfords.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Michael Brennan <mbrennan@ezrs.com>, linux-kernel@vger.kernel.org
In-Reply-To: <40BBB5F7.1010407@yahoo.com.au>
References: <40BB88B5.8080300@ezrs.com>
 <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk>
 <40BBB5F7.1010407@yahoo.com.au>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > However, if 57 Mb of swap allows this, 57 Mb of extra physical RAM should also
> > also allow the grep to be cached, without having to swap out anything.
> > 
> 
> Well yes, but if I had another 57MB of physical memory then I would
> still turn on swap so that other 57MB of unused memory isn't wasted.

Sure, but tell me, for example, what is the point of having swap on a system
like this:

$ free
             total       used       free     shared    buffers     cached
Mem:        516688      19900     496788          0        628      11276
-/+ buffers/cache:       7996     508692
Swap:            0          0          0

John.
