Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289140AbSAVERm>; Mon, 21 Jan 2002 23:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289142AbSAVERa>; Mon, 21 Jan 2002 23:17:30 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:3727 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S289140AbSAVERP>;
	Mon, 21 Jan 2002 23:17:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Adam Keys <akeys@post.cis.smu.edu>, "Partha Narayanan" <partha@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Performance Results for Ingo's O(1)-scheduler
Date: Mon, 21 Jan 2002 20:16:28 -0800
X-Mailer: KMail [version 1.3.8]
Cc: mingo@elte.hu
In-Reply-To: <OF4544D2BC.16B7A12D-ON85256B48.00817250@raleigh.ibm.com> <20020122035540.ZUVU10199.rwcrmhc53.attbi.com@there>
In-Reply-To: <20020122035540.ZUVU10199.rwcrmhc53.attbi.com@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200201212016.29055.bodnar42@phalynx.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 21, 2002 19:55, Adam Keys wrote:
> I'm curious about the performance of the 4-way and 8-way systems.  I know
> nothing about this benchmark.  IIRC correctly it simulates chat clients
> connecting to a server and talking to each other.  Is it a CPU, memory, or
> disk bound benchmark?  What is causing the 4-way machines to be only 2x the
> performance of the 1-way machine and the 8-way machines to be < 3x the
> performance?  Is the system bus the limiting factor on those machines?

Memory bus, lock contention, syncronization issues. SMP really isn't as 
magical as people think after the overhead is taken in to account.

-Ryan
