Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbSLSTtC>; Thu, 19 Dec 2002 14:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbSLSTtC>; Thu, 19 Dec 2002 14:49:02 -0500
Received: from [81.2.122.30] ([81.2.122.30]:51976 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266041AbSLSTtB>;
	Thu, 19 Dec 2002 14:49:01 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212192008.gBJK8g7P002563@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: eli.carter@inet.com (Eli Carter)
Date: Thu, 19 Dec 2002 20:08:42 +0000 (GMT)
Cc: dank@kegel.com, linux-kernel@vger.kernel.org
In-Reply-To: <3E020B37.4070409@inet.com> from "Eli Carter" at Dec 19, 2002 12:08:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, have you looked at other bug tracking programs?  Can you find 
> something you can build on?  Take a look at this list of issue tracking 
> software:
> http://www.a-a-p.org/tools_tracking.html
> It has a lot of possibilities... different combinations of features and 
> implementation languages.
> 
> Could you perhaps expound a bit on your statement "there is nothing 
> about [bugzilla] that I think [is] right at the moment"?

* It uses Javascript in the search forms
* The search forms are not intuitive to use
* It's difficult to check that you're not reporting a duplicate bug
* It's almost all only web-based
* There is no way that you can track different versions to the extent
  we need to.

The last point is the one that I think is most important.

Whenever somebody posts a bug report to LKML, quite often the first
thing somebody asks them is whether they have tried another kernel
version.  Most people don't have the time to try more than, say,
three different versions, and a lot of people might not want to use
the 2.5 development tree.

We _need_ a way to add data to a bug report like this:

* Original bug reporter reports a bug in 2.4.20.  It was also in
2.4.19

* Somebody else tries older versions, and discovers that it was
introduced in 2.4.15

* A third person discovers that recent 2.5 kernels are not affected,
because the code has been re-written.

Each time, information is added to the bug database _in a way that can
be easily searched_, not just as comments which cannot.

I don't know of an existing bug database system which can do that, or
is close to being able to do that.

John.
