Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVETPAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVETPAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 11:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVETPAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 11:00:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:65489 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261430AbVETPAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 11:00:41 -0400
Message-ID: <428DF95E.2070703@free.fr>
Date: Fri, 20 May 2005 16:51:10 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
References: <428CD458.6010203@free.fr> <20050519182302.GE23621@csclub.uwaterloo.ca> <428CED0C.9020607@nortel.com> <20050520125511.GC23488@csclub.uwaterloo.ca>
In-Reply-To: <20050520125511.GC23488@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

 > I believe Linux currently implements threads as seperate processes (at
 > least top and ps sees them that way).

> Have you tried NPTL (native posix threading library) which is supposed
> to become the threading standard on linux in the future (if it works
> out)?

Lennart,

 From the beginning we are talking about the present GNU/Linux systems, 
which do already use NTPL in standard. NPTL is no future standard, it is 
present standard.

This means basicly that 50% of your assertions (like the above) are 
wrong, and your conclusions "suffer" from that :)

The point is that if you make a ps on a decent Linux based system, you 
will *NOT* see one process for each thread. Nor they do appear in /proc.

This means there are *NOT* userland processes.

And therefore, you shall *NOT* be able to reference them as such where a 
process ID is required.

