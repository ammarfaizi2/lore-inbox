Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVHKPFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVHKPFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVHKPFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:05:19 -0400
Received: from amdext4.amd.com ([163.181.251.6]:49843 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751052AbVHKPFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:05:18 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Thu, 11 Aug 2005 09:06:50 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Todd Poynor" <tpoynor@mvista.com>
cc: "Dave Jones" <davej@redhat.com>, "Bruno Ducrot" <ducrot@poupinou.org>,
       "Pavel Machek" <pavel@ucw.cz>, cpufreq@lists.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: PowerOP 2/3: Intel Centrino support
Message-ID: <20050811150650.GG26524@cosmic.amd.com>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
 <20050810100133.GA1945@elf.ucw.cz> <20050810125848.GM852@poupinou.org>
 <20050810184445.GB14350@redhat.com> <42FA8FC0.5000700@mvista.com>
MIME-Version: 1.0
In-Reply-To: <42FA8FC0.5000700@mvista.com>
User-Agent: Mutt/1.5.8i
X-WSS-ID: 6EE5B74C1UW9123264-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've attempted to extoll the benefits of adding these interfaces in 
> previous emails, and if after that it still seems mystifying why anybody 
> would want to do this then I'll take the heat for doing a lousy job of 
> extolling.  I've also admitted that it is primarily of use in 
> embedded-specific hardware, and of less use in x86 and in desktop/server 
> usage for various reasons (unless it turns out there's some fantastic 
> savings to be had in modifying common x86 bus speeds independently of 
> cpu speed, which seems unlikely).  In the case of x86, undervolting is 
> in practice by some folks, but yes it is risky and support for it in the 
> basic interfaces probably shouldn't be a high priority.

I would like to toss in my support to Todd, if he'll take it.  When it comes
to embedded power management concepts, a consistant theme is that people
often question the usefulness, redundancy or complexity of a solution.  This
is perfectly understandable, since such a huge majority of the power
management experts and users are concentrating intently on x86 desktops and
servers.  Thats nobody's fault in particular, just a natural result of a
Wintel world gone mad.

At the PM BOF at OLS, when we started discussing runtime management, somebody
mentioned that one of the problems with RTPM is the complexity.  As an
embedded Linux developer, I hope I speak for the entire embedded community
when I say that we welcome that complexity - we are willing to do anything 
we can do to squeak every single millivolt out of our platforms.

But as a laptop owner, I can see the other side of the coin as well - I don't
know the specific voltages that my laptop uses, and I don't want to know. 

In short, we have different goals, but our hearts are in the the same place.
These same concepts are going to show up more and more in the future, and
eventually somebody is going to start shipping less then optimal solutions,
just to get something to market.  This list can either lend its expertise, or
complain when somebody else gets it wrong.  The second one might seem more
fun, but I hope we can agree its far less productive.. :)

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

