Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269946AbRHQIgr>; Fri, 17 Aug 2001 04:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269944AbRHQIgm>; Fri, 17 Aug 2001 04:36:42 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:38652 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269918AbRHQIg1>;
	Fri, 17 Aug 2001 04:36:27 -0400
Subject: Re: [PATCH] processes with shared vm
From: Robert Love <rml@tech9.net>
To: Andi Kleen <ak@suse.de>
Cc: Terje Eggestad <terje.eggestad@scali.no>, linux-kernel@vger.kernel.org
In-Reply-To: <oupelqbw0z4.fsf@pigdrop.muc.suse.de>
In-Reply-To: <997973469.7632.10.camel@pc-16.suse.lists.linux.kernel> 
	<oupelqbw0z4.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 17 Aug 2001 04:31:06 -0400
Message-Id: <998037089.1013.20.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001 10:21:35 +0200, Andi Kleen wrote:
> The basic idea is a good one (I have written a similar thing in the past ;)
> Your implementation is O(n^2) however in ps, which is not acceptable.
> <snip>

Is there any reason your patch was not accepted?  Perhaps for 2.5?

This is something (along with userspace changes to take advtantage of
it) that I think is really needed -- no more bogus ps/top reports.

I liked Terje's idea, but obviously the scalability needs to be improved
(I didn't even notice it, sadly).  I would really want to see this at
some point.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

