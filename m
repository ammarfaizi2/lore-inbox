Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVBVUQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVBVUQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVBVUQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:16:18 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:40620 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261212AbVBVUQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:16:16 -0500
Message-ID: <421B9309.6080503@nortel.com>
Date: Tue, 22 Feb 2005 14:16:09 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anthony DiSante <theant@nodivisions.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu> <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no> <421B14A8.3000501@nodivisions.com> <Pine.LNX.4.61.0502220824440.25089@chaos.analogic.com> <421B9018.7020007@nodivisions.com>
In-Reply-To: <421B9018.7020007@nodivisions.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony DiSante wrote:
> linux-os wrote:
> 
>> There has been some discussion that these hung
>> states could be "fixed", but that's absolutely
>> positively incorrect.
> 
> 
> That's one of the things I asked a few messages ago.  Some people on the 
> list were saying that it'd be "really hard" and would "require a lot of 
> bookkeeping" to "fix" permanently-D-stated processes... which is 
> completely different than "impossible."

Nothing is "impossible".  Cracking SHA-256 isn't "impossible", it just 
takes more computing power than exists on the face of the planet.

Call it "infeasable" if you like.  It's theoretically possible, but the 
amount of work and the overhead involved just are not realistic.  And 
then you have the likelihood of a bug in the bookkeeping code leading to 
runtime corruption...  Better to take the hit now and fix the original 
problem.

Chris
