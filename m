Return-Path: <linux-kernel-owner+w=401wt.eu-S965176AbXAGV2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbXAGV2G (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 16:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbXAGV2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:28:05 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:40040 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965176AbXAGV2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:28:05 -0500
Date: Sun, 7 Jan 2007 13:27:52 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, md@google.com, mingo@elte.hu, pravin.shelar@calsoftinc.com,
       shai@scalex86.org
Subject: Re: + spin_lock_irq-enable-interrupts-while-spinning-i386-implementation.patch added to -mm tree
Message-ID: <20070107212752.GB7436@localhost.localdomain>
References: <200701032112.l03LCnVb031386@shell0.pdx.osdl.net> <1168122953.26086.230.camel@imap.mvista.com> <20070106232641.68511f15.akpm@osdl.org> <1168176285.26086.241.camel@imap.mvista.com> <20070107120503.ceadb6ed.akpm@osdl.org> <20070107210658.GA7436@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107210658.GA7436@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 01:06:58PM -0800, Ravikiran G Thirumalai wrote:
> 
> 
> Question is, now we have 2 versions of spin_locks_irq implementation
> with CONFIG_PARAVIRT -- one with regular cli sti and other with virtualized 
> CLI/STI -- sounds odd!

Sunday morning hangovers !! spin_lock_irq is not inlined so there is just one
version even with CONFIG_PARAVIRT.

Thanks,
Kiran
