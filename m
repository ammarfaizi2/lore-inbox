Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSJaOzQ>; Thu, 31 Oct 2002 09:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbSJaOzQ>; Thu, 31 Oct 2002 09:55:16 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:60071 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262129AbSJaOzP>; Thu, 31 Oct 2002 09:55:15 -0500
Subject: Re: What's left over.
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, n2m1@ltc-eth1000.torolab.ibm.com,
       Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6286E52C.B464C16B-ON80256C63.005132DB@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Thu, 31 Oct 2002 14:56:27 +0000
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 31/10/2002 15:01:22
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Crash Dumping (LKCD)
>
>This is definitely a vendor-driven thing. I don't believe it has any
>relevance unless vendors actively support it.

I can't argue with the fact you want to view lkcd this way. However as a
developer I have found a crash dump facility indispensable for certain
problems, particularly those that involve multiple processors where to use
more invasive techniques such as an interactive debugger can make the
problem unreproducible. It's also worth pointing out that each of the
serviceability tools (dump, trace, probes) complements each other. They are
every so much more powerful when used as a set: lkcd can capture a trace
buffer, whose contents would otherwise be lost; kprobes enables LTT to
implant tracepoints dynamically; krpobes + lkcd allows a crash dump to be
triggered for complex and specific conditions that are difficult to
reproduce. Without such tools, data gathering for complex problems becomes
a problem in itself.  A problem doesn't necessarily have to be reproducible
to make it necessary to solve.


Richard

