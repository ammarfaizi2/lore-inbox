Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268313AbUH3UTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268313AbUH3UTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUH3UTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:19:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5591 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268313AbUH3US6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 16:18:58 -0400
Date: Mon, 30 Aug 2004 20:56:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jan Beulich <JBeulich@novell.com>
Cc: akpm@osdl.org, mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: Fw: x86 build issue with software suspend code
Message-ID: <20040830185618.GC505@openzaurus.ucw.cz>
References: <s132dddc.000@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s132dddc.000@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I can't find anything about nosave section in cpu.c... Can you quote
> it?
> 
> Ah, I see. This is the only piece I didn't double-check against the
> 2.6.8.1 sources (I found the problem originally in the SuSE 2.6.5
> derivate, where the kernel.org version didn't have swsusp_pg_dir at all,
> yet), and indeed in the kernel.org version swsusp_pg_dir lives in
> arch/i386/mm/init.c (one might argue which of the placements is the
> better one).
> 
> Still, to prevent issues in the future as well as such like seen with
> SuSE, the patch seems necessary to me.

Yes, the patch is okay. Can you send it to andrew for inclusion?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

