Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315335AbSFXV5M>; Mon, 24 Jun 2002 17:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSFXV5L>; Mon, 24 Jun 2002 17:57:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:65192 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315335AbSFXV5L>;
	Mon, 24 Jun 2002 17:57:11 -0400
Date: Mon, 24 Jun 2002 14:56:14 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Craig Kulesa <ckulesa@as.arizona.edu>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@suse.de>, Daniel Phillips <phillips@bonn-fries.net>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rwhron@earthlink.net
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Message-ID: <752101.1024930574@mbligh.des.sequent.com>
In-Reply-To: <Pine.LNX.4.44L.0206241837400.18418-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0206241837400.18418-100000@imladris.surriel.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> A quick rough calculation indicates that the Oracle test I was helping
>> out with was consuming almost 10Gb of PTEs without rmap - 30Gb for
>> overhead doesn't sound like fun to me ;-(
> 
> 10 GB is already bad enough that rmap isn't so much causing
> a problem but increasing an already untolerable problem.

Yup, I'm not denying there's an large existing problem there, but 
at least we can fit it into memory right now. Just something to bear
in mind when you're benchmarking.

> Now we just need volunteers for the implementation ;)

We have some people looking at it already, but it's not the world's
most trivial problem to solve ;-)

M.
