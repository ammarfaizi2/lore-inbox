Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287881AbSAUSxC>; Mon, 21 Jan 2002 13:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSAUSwy>; Mon, 21 Jan 2002 13:52:54 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:31437 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S287881AbSAUSws>; Mon, 21 Jan 2002 13:52:48 -0500
Message-ID: <3C4C6500.990E0173@nortelnetworks.com>
Date: Mon, 21 Jan 2002 13:59:12 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <E16ShcU-0001ip-00@starship.berlin> <20020121095051.B14139@hq.fsmlabs.com> <3C4C50C9.8C7D5B6F@nortelnetworks.com> <20020121105237.A15414@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
> On Mon, Jan 21, 2002 at 12:32:57PM -0500, Chris Friesen wrote:
> > yodaiken@fsmlabs.com wrote:
> >
> > > So your claim is that:
> > >         Preemption improves latency when there are both kernel cpu bound
> > >         tasks and tasks that are I/O bound with very low cache hit
> > >         rates?
> > >
> > > Is that it?
> > >
> > > Can you give me an example of a CPU bound task that runs
> > > mostly in kernel? Doesn't that seem like a kernel bug?
> >
> > cat /dev/urandom > /dev/null
> 
> Don't see any of Daniel's postulated long latencies there.  (Sorry, but
> I'm having a hard time figuring out what is meant as a serious comment
> here).

No, that one wasn't serious.  And while it is CPU bound and mostly in the
kernel, you're right that there are no long latencies to cause issues...

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
