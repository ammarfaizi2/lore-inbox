Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSANW2Y>; Mon, 14 Jan 2002 17:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289102AbSANW2U>; Mon, 14 Jan 2002 17:28:20 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:933 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S289108AbSANW0e>; Mon, 14 Jan 2002 17:26:34 -0500
Message-ID: <3C435C85.C4841FDE@nortelnetworks.com>
Date: Mon, 14 Jan 2002 17:32:37 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
In-Reply-To: <20020114165909.A20808@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Scenario #3: Penelope goes where the geeks are surfing.

> If Penelope learns from the README file that all *she* has to do is
> type "configure; make" to build a kernel that supports her hardware,
> she can apply that MEMS card patch and build with confidence that the
> effort is unlikely to turn into an infinite time sink.
> 
> Autoconfigure saves the day again.  That guy in the penguin T-shirt
> might even be impressed...

Is anyone arguing that autoconfig is *unconditionally bad*?

As long as it doesn't impact the ability to continue setting things manually, I
don't see how it could be bad.

For instances where you're building a new kernel on the system it's going to run
on, and you want all the devices, then use autoconfig.  For anything else,
either start from scratch as usual or use autoconfig as a base to start from.

As long as we still have manual control if we want it, I don't see any problems.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
