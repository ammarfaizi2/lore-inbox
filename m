Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273648AbRJNCEF>; Sat, 13 Oct 2001 22:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJNCDz>; Sat, 13 Oct 2001 22:03:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:56292 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273796AbRJNCDq>; Sat, 13 Oct 2001 22:03:46 -0400
From: "Paul E. McKenney" <pmckenne@us.ibm.com>
Message-Id: <200110140204.f9E24B719058@eng4.beaverton.ibm.com>
Subject: Re: Re: RFC: patch to allow lock-free traversal of lists
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 13 Oct 2001 19:04:11 -0700 (PDT)
Cc: Paul.McKenney@us.ibm.com (Paul McKenney), dipankar@us.ibm.com,
        linux-kernel@vger.kernel.org, rusty@rustcorp.com.au (Rusty Russell)
In-Reply-To: <Pine.LNX.4.33.0110131024480.8707-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 13, 2001 09:28:13 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sat, 13 Oct 2001, Linus Torvalds wrote:
>>
>> In short, RCU seems to be a case of "hey, that's cool", but it's a
>> solution in search of a problem so severe that it is worth it.
>
>Oh, and before people start telling me that RCU was successfully used in
>AIX/projectX/xxxx/etc, you have to realize that I don't give a rats *ss
>about the fact that there are OS's out there that are "more scalable".

I understand and agree: RCU must prove itself -in- -Linux-.

>The last time I looked, Solaris and AIX and all the rest of the "scalable"
>systems were absolute pigs on smaller hardware, and the "scalability" in
>them often translates into "we scale linearly to many CPU's by being
>really bad even on one".

Again understood and agreed.  Simplicity and single-CPU performance are
at least as important as scalability.  Although I believe that RCU can
be an important part of all three in some situations, this belief is
clearly in need of more proof.

						Thanx, Paul
