Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUCNAvL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbUCNAvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:51:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:62129 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261421AbUCNAvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:51:08 -0500
Date: Sat, 13 Mar 2004 16:51:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joerg Sommrey <jo@sommrey.de>
Cc: linux-kernel@vger.kernel.org, Philippe Elie <phil.el@wanadoo.fr>
Subject: Re: NMI watchdog in 2.6.3-mm4/2.6.4-mm1
Message-Id: <20040313165112.31ef6939.akpm@osdl.org>
In-Reply-To: <20040313214255.GA4205@sommrey.de>
References: <20040313214255.GA4205@sommrey.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Sommrey <jo@sommrey.de> wrote:
>
> n my box (Tyan Tiger MPX / 2x AMD Athlon) the NMI watchdog never worked
>  on any kernel that I tried (2.4.x, 2.6.x). I always found:
>  | activating NMI Watchdog ... done.
>  | testing NMI watchdog ... CPU#0: NMI appears to be stuck!
> 
>  But there is one exception: 2.6.3-mm4 shows:
>  | activating NMI Watchdog ... done.
>  | testing NMI watchdog ... OK.
> 
>  [2.6.3-mm4 was the only -mmX kernel I tried so far.]
> 
>  With 2.6.4-mm1 the NMI watchdog is again not functional in my box. Any
>  ideas?

Please try the next -mm.  If that still has problems I'll drop both the
remaining NMI patches and would request that Phillippe ask you to test any
future NMI patches on that machine.

