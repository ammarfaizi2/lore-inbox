Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTJ1MGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 07:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTJ1MGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 07:06:15 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:21521 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263962AbTJ1MGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 07:06:11 -0500
Message-ID: <3F9E5DFA.2000008@aitel.hist.no>
Date: Tue, 28 Oct 2003 13:15:54 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: no, en
MIME-Version: 1.0
To: Stef van der Made <svdmade@planet.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Heavy disk activity without apperant reason (added more info)
References: <3F9BC429.6060608@planet.nl> <3F9D0BBB.9080600@aitel.hist.no> <3F9D7120.1020207@planet.nl>
In-Reply-To: <3F9D7120.1020207@planet.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stef van der Made wrote:
> 
> Dear Helge,
> 
> I had the very interesting disk activity again. No serious activity was 
> happening. I've tried to make some sense of the 2 output commands you've 
> asked, but they make not much sense. Sorry :-( that I need to ask so 
> much help on this (bug) report.
> 
> This is the output of vmstat

[...]
>From this we see that it isn't swapping (0 in the si and so
columns {"swap in" and "swap out"}). 
The machine occationally reads, and it writes a lot.

> and this is top
> 
dnetc is the most active process here.  I don't know
what it _is_ - could it be doing lots of disk
writes?  

mozilla is running, it may do a lot of disk
access under some circumstances, for example
when refreshing some webpage with lots
of content.

Helge Hafting

