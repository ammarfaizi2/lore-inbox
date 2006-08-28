Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWH1Uuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWH1Uuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWH1Uug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:50:36 -0400
Received: from dsl092-068-022.bos1.dsl.speakeasy.net ([66.92.68.22]:55521 "EHLO
	george.mindlace.net") by vger.kernel.org with ESMTP id S932108AbWH1Uuf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:50:35 -0400
Message-ID: <44F356C3.3040806@mindlace.net>
Date: Mon, 28 Aug 2006 16:49:07 -0400
From: emf <i@mindlace.net>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: emf <i@mindlace.net>
CC: linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2004@gmx.net
Subject: Re: segfaults, kernel panic using forcedeth nvidia 4
References: <44F06BB0.4090200@mindlace.net>
In-Reply-To: <44F06BB0.4090200@mindlace.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 66.92.68.253
X-SA-Exim-Mail-From: i@mindlace.net
X-SA-Exim-Scanned: No (on george.mindlace.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I've got some oops output... if someone could give me the faintest 
idea as to what is wrong, I would be much obliged.

http://mindlace.net/tmp/latest_segfault.txt

emf wrote:
> Hello!
> 
> I'm using debian's 2.6.17-2-amd64 (after having these issues with 2.6.16).
> 
> I'm running software raid 5 and LVM on the partition in question; the 
> machine is connected to my server via gigabit ethernet over the onboard 
> nforce4 ethernet- my motherboard is  Gigabyte GA-M51GM-S2G Socket AM2 
> NVIDIA GeForce 6100, and the CPU is a AMD Sempron 64 2800+.
> 
> When I try to rsync from my old server, I get user-land segfaults (bash 
> and sh, mostly) and the machine hangs. This happens with straight scp as 
> well, and it is 100% replicable. The error messages look like:
> 
> sh[5325]: segfault at 0000000081cc893a rip 00002ae181c2bf02 rsp 
> 00007fffff927c58 error 4
> 
> I've now successfully tried copying a large number of files via a 
> machine connected through a 100mbit connection, without issue.
> 
> This leads me to think that it's forcedeth having the problem, but I had 
> also thought that perhaps I'm asking too much of the md/lvm subsystem.
> 
> I've ordered another gigabit ethernet card and a new AMD64x2 cpu, so I 
> should be able to test these issues more cleanly.
> 
> In the meantime, is there anything I can do to diagnose these issues?
> 
> Thanks (and please cc me; I'm not a kernel-type by default.)
> 
> ~ethan fremen
> 

