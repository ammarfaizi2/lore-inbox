Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289162AbSAVF1J>; Tue, 22 Jan 2002 00:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289163AbSAVF1A>; Tue, 22 Jan 2002 00:27:00 -0500
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:20419 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S289162AbSAVF0x>; Tue, 22 Jan 2002 00:26:53 -0500
Date: Tue, 22 Jan 2002 00:28:09 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Adam Keys <akeys@post.cis.smu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Performance Results for Ingo's O(1)-scheduler
In-Reply-To: <20020122035540.ZUVU10199.rwcrmhc53.attbi.com@there>
Message-ID: <Pine.LNX.4.33.0201220026350.19491-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> connecting to a server and talking to each other.  Is it a CPU, memory, or 
> disk bound benchmark?  What is causing the 4-way machines to be only 2x the 

none of the above: it's scheduler-bound: billions of runnable threads
that do almost nothing but wake up other threads. a fine example of 
where to use coroutines, not kernel threads...

