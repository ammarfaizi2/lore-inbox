Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVJEL0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVJEL0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVJEL0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:26:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:18841 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965116AbVJELZ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:25:59 -0400
Date: Wed, 5 Oct 2005 12:25:58 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: subbie subbie <subbie_subbie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
Message-ID: <20051005112558.GC18448@gallifrey>
References: <Pine.LNX.4.62.0510011957010.26437@dark.webcon.ca> <20051005064339.80683.qmail@web30303.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005064339.80683.qmail@web30303.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3 (i686)
X-Uptime: 12:23:26 up 32 days, 23:49, 64 users,  load average: 0.01, 0.05, 0.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Something is very wrong with this card / driver /
> firmware and or kernel combination,  hopefully someone
> can help out.

I think I have to agree; see my post from:

http://marc.theaimsgroup.com/?l=linux-kernel&m=112282837926689&w=2

I've got about 30MB/s from a single threaded version of my
backup code - which seems rather on the low side for
a modern RAID-5; with multiple writers I was seeing sub-5MB/s
but that might be fair if it is seeking everywhere.

I'd be interested to hear how your experiments with jbod'ing them
go.

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
