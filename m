Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbRAaRWC>; Wed, 31 Jan 2001 12:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132497AbRAaRVt>; Wed, 31 Jan 2001 12:21:49 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:7893 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S131409AbRAaRVj>; Wed, 31 Jan 2001 12:21:39 -0500
Date: Wed, 31 Jan 2001 09:13:22 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: gprof cannot profile multi-threaded programs
To: Mohit Aron <aron@cs.rice.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: dank@alumni.caltech.edu
Message-id: <3A7847B2.E33E8A87@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <200101310727.BAA14161@cs.rice.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohit Aron wrote:
> 
> > http://opensource.corel.com/cprof.html
> >
> > I haven't used it yet, myself.
> >
> 
> I have. cprof is no good - extremely slow and generates a 100MB trace
> even with a simple hello world program.

Oh.  Bleh.

http://wordindex.sourceforge.net/testdata/usenet.col-20000817-1548/028-123.col.txt.txt
mentioned a workaround for gprof, I don't know if it's real:

> AFAIK gprof doesn't support multithreaded apps profiling, but you can
> workaround it if you call getitimer() in the main thread for ITIMER_PROF
> then using that value in a call to setitimer() in every thread you
> spawn. Other alternative is using the open source cprof by Corel [I
> never 

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
