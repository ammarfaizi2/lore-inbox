Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRJNBhb>; Sat, 13 Oct 2001 21:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRJNBhV>; Sat, 13 Oct 2001 21:37:21 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:49083 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273204AbRJNBhL>; Sat, 13 Oct 2001 21:37:11 -0400
From: "Paul E. McKenney" <pmckenne@us.ibm.com>
Message-Id: <200110140137.f9E1bYN18728@eng4.beaverton.ibm.com>
Subject: Re: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Sat, 13 Oct 2001 18:37:34 -0700 (PDT)
Cc: torvalds@transmeta.com (Linus Torvalds), dipankar@in.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E15sWCI-0005tP-00@wagner> from "Rusty Russell" at Oct 14, 2001 06:19:54 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Where, if anywhere, is this worth it?  Good question: 3% on 4-way
>dbench doesn't cut it in my book...

No argument here, we need to show compelling performance cases for RCU in
a number of situations.  We have some (e.g., for FD set management on
8-way reported at OLS), but need more.  We will continue to work on this.

If nothing else, this thread seems to have raised awareness of RCU.  ;-)

						Thanx, Paul
