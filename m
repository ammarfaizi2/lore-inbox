Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263222AbVCKHIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbVCKHIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 02:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbVCKHIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 02:08:47 -0500
Received: from one.firstfloor.org ([213.235.205.2]:16041 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S263222AbVCKHHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 02:07:55 -0500
To: Chris Friesen <cfriesen@nortel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
References: <20050309072833.GA18878@kroah.com>
	<16944.6867.858907.990990@cse.unsw.edu.au>
	<1110449872.6291.64.camel@laptopd505.fenrus.org>
	<16944.63807.579725.848224@cse.unsw.edu.au>
	<4231258C.3060400@nortel.com>
From: Andi Kleen <ak@muc.de>
Date: Fri, 11 Mar 2005 08:07:52 +0100
In-Reply-To: <4231258C.3060400@nortel.com> (Chris Friesen's message of "Thu,
 10 Mar 2005 22:58:52 -0600")
Message-ID: <m1ekemzmlz.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortel.com> writes:

> Neil Brown wrote:
>
>> If a data corruption bug has been there for 10 weeks without being
>> noticed, then the real risk is not that great.  We are calling it
>> "-release", not "-hardened".
>
> I disagree.  If there's a simple, obvious, small fix that passes all
> the other criteria, it should go into -stable ASAP after passing
> review. Then the -stable maintainers will push the fix to
> Andrew/Linux, and it will go into the next 2.6.x.

No way, it needs to go into mainline first and then maybe later
into stable. Doing stable first would lead to code drift because
a lot of people would only care about stable and we would be back
in the bad old days when older kernels had more fixes than newer
ones.

-Andi
