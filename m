Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVIAOYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVIAOYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbVIAOYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:24:20 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:9652 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965140AbVIAOYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:24:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Anupama Chandwani <anupama.chandwani@gmail.com>
Subject: Re: swappable scheduler in linux kernel
Date: Fri, 2 Sep 2005 00:23:21 +1000
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>
References: <689eb34705090107196f3ef558@mail.gmail.com>
In-Reply-To: <689eb34705090107196f3ef558@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509020023.22485.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005 00:19, Anupama Chandwani wrote:
> Hello,
>  I am a final year coputre enginering student from Pune university,India.
> Im interested in linux kernel & saw the plugsched echanism, how its been
> made possible to change schedler policy at compile time.
>
> However, Im thinking of a scheduler that can dynamically change its policy
> or soe part of code for that matter hot swap with a copletely different
> scheduler at RUNTIME. something like IBM's K42. We can have scheduler modes
> like realtime or interactive which can be changed at runtime.
>   Though its a pretty much completed problem to solve, there seem to be
> little commertial need of it.. can you suggest of its application or maybe
> your comments on this idea.

Runtime modification has possible uses in the form of hot scheduler upgrades 
for systems in production for security upgrades or performance enhancements, 
with virtually nil downtime. This was one of my ultimate aims when pushing 
the original plugsched infrastructure. However both Linus and Ingo did not 
like the plugsched idea at all thinking it would fragment work effort put 
into the mainline scheduler and have lots of less good schedulers instead of 
one scheduler to rule them all.

Cheers,
Con
