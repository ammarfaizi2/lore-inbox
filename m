Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269171AbRHBWJm>; Thu, 2 Aug 2001 18:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269177AbRHBWJc>; Thu, 2 Aug 2001 18:09:32 -0400
Received: from waste.org ([209.173.204.2]:23592 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S269171AbRHBWJ0>;
	Thu, 2 Aug 2001 18:09:26 -0400
Date: Thu, 2 Aug 2001 17:09:04 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: george anzinger <george@mvista.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: No 100 HZ timer !
In-Reply-To: <3B69C394.4A0C20B9@mvista.com>
Message-ID: <Pine.LNX.4.30.0108021641250.2340-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, george anzinger wrote:

> I guess I am confused.  How is it that raising HZ improves throughput?
> And was that before or after the changes in the time slice routines that
> now scale with HZ and before were fixed?  (That happened somewhere
> around 2.2.14 or 2.2.16 or so.)

My guess is that processes that are woken up for whatever reason get to
run sooner, reducing latency, and thereby increasing throughput when not
compute-bound. Presumably this was with shorter time slices.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

