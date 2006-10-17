Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWJQIIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWJQIIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 04:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWJQIIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 04:08:06 -0400
Received: from main.gmane.org ([80.91.229.2]:9942 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932226AbWJQIIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 04:08:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Inspiron 6000 and CPU power saving
Date: Tue, 17 Oct 2006 08:07:25 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnej945u.2m4.olecom@flower.upol.cz>
References: <4532EBE2.6090709@knobbits.org>
Reply-To: Oleg Verych <olecom@flower.upol.cz>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, Michael.

On 2006-10-16, Michael (Micksa) Slade wrote:
> I recently discovered that my Inspiron 6000 uses about 50% more power 
> idling in linux than in windows XP.  This means its battery life is 
> about 2/3 of what it could/should be.
>
> I guessed it might be the CPU, and did some tests.  The results strongly 
> suggest as much.  These are the results I got for power consumption in 
> various situations.
>
> linux idle at 800MHz: 27W        
> linux idle at 1600MHz: 36W        
> linux raytracing at 800: 30W
> linux raytracing at 1600: 42W 
>
> windows idle (presumably 800MHz): 16W
> windows raytracing (presumably 1600MHz): 36W
>
> I've tried ubuntu dapper and ubuntu edgy, and RIP 10 (rescue disk) and 
> BBC 2.1 (rescue disk), and they all appear to have the same issue.  The 
> machine's BIOS has no APM so I can't try it for comparison.

After reading all that, i think this is wrong list to post such things.

Anyway.
Note, that you didn't mentioned yours shiny laptop's architecture.
More to that, if it's cool-modern CPU from Intel or just a AMD's one,
what linux-kernel version you're running? As for me, i don't know
neither what Inspiron 6000 is, nor kernel versions "ubuntu dapper
(edgy)" is running. And if you will know all that information, better keep
it for your's google skills, not for further postings here.

Also if you want to compare power consumption, better include time
tasks ran, thus one can estimate real *work* done by system for
application and finally amount of actual heat.

> I need help digging deeper.  I guess /proc/acpi/processor/CPU0/power 
> could give some insight but I'm not sure how to read the numbers.  That 
> and "learn about ACPI" is all I can figure out so far.

Search lkml for 'ACPI' and 'Linus', after that, just relax and reboot to
windo$ and forget anything else ;)

> So where to from here?  I am prepared to spend a significant amount of 
> time researching and resolving the issue, so feel free to suggest 
> reading the ACPI spec or whatever if that's what it's going to take.

If you _really_ want to do something --  read sources, build kernels,
tune kernels and somewhere in between RTFM. And finally share results.
____

