Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSGJH4X>; Wed, 10 Jul 2002 03:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSGJH4W>; Wed, 10 Jul 2002 03:56:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7699 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314403AbSGJH4V>;
	Wed, 10 Jul 2002 03:56:21 -0400
Message-ID: <3D2BEAD9.6D7E62C1@zip.com.au>
Date: Wed, 10 Jul 2002 01:05:45 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.4 BUFFERING BUG] (was [BUG] 2.4 VM sucks. Again)
References: <200205241004.g4OA4Ul28364@mail.pronto.tv> <1572079531.1022225730@[10.10.2.3]> <3CEE954F.9CB99816@zip.com.au> <200207100950.21084.roy@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> hi
> 
> I've been using the patch below from Andrew for some weeks now, sometimes
> under quite heavy load, and find it quite stable.
> 

Wish we knew why.  I've tried many times to reproduce the problem
which you're seeing.  With just two gigs of memory, buffer_heads
really cannot explain anything.  It's weird.

We discussed this in Ottawa - I guess Andrea will add the toss-the-buffers
code on the read side (basically the filemap.c stuff).  That may
be sufficient, but without an understanding of what is going on,
it is hard to predict.

-
