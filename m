Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbRFKQOz>; Mon, 11 Jun 2001 12:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbRFKQOp>; Mon, 11 Jun 2001 12:14:45 -0400
Received: from beasley.gator.com ([63.197.87.202]:35333 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S261390AbRFKQOn>; Mon, 11 Jun 2001 12:14:43 -0400
From: "George Bonser" <george@gator.com>
To: "Daniel Stone" <daniel@kabuki.sfarc.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.6-pre2 page_launder() improvements
Date: Mon, 11 Jun 2001 09:18:07 -0700
Message-ID: <CHEKKPICCNOGICGMDODJMEMFDEAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20010611130314.B964@kabuki.openfridge.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran some more tests yesterday with a little more RAM than last 
time and Rik's kernel performed much better than the vanilla kernel 
in the face of memory pressure when it was very busy. I could get 
both kernels into situations where they were unresponsive but these 
periods of time were much shorter with Rik's than with vanilla 
2.4.6-pre2.  A background kernel compile completed much faster  on
Rik's version on a fairly busy web server with 128MB of RAM.

I goofed and forwarded the vmstat logs to the linux-mm
mailing list so there is a huge message there with my results :-/
but I can forward them to anyone interested.


