Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbUL0Ckq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUL0Ckq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 21:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbUL0Ckq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 21:40:46 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:26771 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261738AbUL0Ckj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 21:40:39 -0500
In-Reply-To: <20041227014138.GA8773@work.bitmover.com>
References: <20041226181837.GA28786@work.bitmover.com> <200412270031.iBR0VBQq032074@laptop11.inf.utfsm.cl> <20041227014138.GA8773@work.bitmover.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B15A995A-57B0-11D9-9777-000A95E3BCE4@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Wayne Scott <wscott@work.bitmover.com>, M?ns Rullg?rd <mru@inprovide.com>,
       linux-kernel@vger.kernel.org, Horst von Brand <vonbrand@inf.utfsm.cl>
From: Martin Dalecki <martin@dalecki.de>
Subject: Re: lease.openlogging.org is unreachable
Date: Mon, 27 Dec 2004 03:40:38 +0100
To: Larry McVoy <lm@bitmover.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-27, at 02:41, Larry McVoy wrote:

> On Sun, Dec 26, 2004 at 09:31:11PM -0300, Horst von Brand wrote:
>>> The other answer, which I'm happy to consider, is to come up with a 
>>> unique
>>> id on a per host basis and use that for the leases.  That's not a 
>>> fun task,
>>> does anyone have code (BSD license please) which does that?
>>
>> MAC of eth0?
>
> As others have pointed out that won't work.
>
> I'm trying to remember why we get leases on a per host basis and I 
> think
> it is for a simple reason, NFS.

Citing from: 
http://www.time-travellers.org/shane/papers/NFS_considered_harmful.html

"NFS fails at the goal of allowing a computer to access files over a 
network as if they were on a local disk. In many ways, NFS comes close 
to the objective, and in certain circumstances (detailed later), this 
is acceptable. However, the subtle differences can cause subtle bugs 
and greater system issues. The widespread misconception about the 
compatibility and transparency of NFS means that it is often used 
inappropriately, and often put into production when better, more 
acceptable solutions exist."

I don't know of a proper solution, other then writing in big letters
in the documentation about the circumstances under which you can shoot 
yourself in
the feet.

Where is NFSv4?

