Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbUCGQY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUCGQY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:24:29 -0500
Received: from 66-95-121-230.client.dsl.net ([66.95.121.230]:25985 "EHLO
	mail.lig.net") by vger.kernel.org with ESMTP id S262207AbUCGQY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:24:27 -0500
Message-ID: <2842.66.95.121.226.1078676666.squirrel@66.95.121.226>
In-Reply-To: <Pine.LNX.4.44.0403071549260.3262-100000@numb.darktech.org>
References: <Pine.LNX.4.44.0403071549260.3262-100000@numb.darktech.org>
Date: Sun, 7 Mar 2004 11:24:26 -0500 (EST)
Subject: Re: KERNEL 2.6.3 and MAXTOR 160 GB
From: "Stephen D. Williams" <sdw@lig.net>
To: "Carlo Orecchia" <carlo@numb.darktech.org>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be sure that you are really connected to a newer IDE controller.  This is what
determines whether the OS sees 137GB or the full amount.

2.6.3 and really all recent kernels have worked on hard drives up to 250GB
with the correct controllers for both IDE and Firewire bridge boards.

Now about those 2.6.3 lockups that I am completely in the dark about...

sdw
-- 
swilliams@hpti.com http://www.hpti.com Per: sdw@lig.net http://sdw.st
Stephen D. Williams 703-724-0118W 703-995-0407Fax 20147-4622 AIM: sdw

On Sun, March 7, 2004 9:57 am, Carlo Orecchia said:
> HI
>
> I'm running redhat 9 on an XP 1800 and a ASUS A7A266. I recently buy a new
> HD a maxtor Diamond Plus 160 with 8 mega cache. The fact is that the kernel
> that comes
> with REDHAT (2.4.20-8) shows the entire size of the disk (163.7 gb) but
> the kernel 2.6.1 or 2.6.3 does not. It only shows 137 gb. I'm getting
> crazy trying to understand why this is happening! Please let
> me know if theres a patch to fix this. I really  found amazing the 2.6
> kernel and i don't want to come back to use the 2.4!
> What can i do?
>
> p.s. let know if you need more info about my system
>
>
> Regards
>
> Carlo Orecchia
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

