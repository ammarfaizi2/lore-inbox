Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWHMHQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWHMHQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 03:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWHMHQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 03:16:38 -0400
Received: from ns.suse.de ([195.135.220.2]:20656 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750734AbWHMHQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 03:16:38 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH for review] [109/145] x86_64: Convert modlist_lock to be a raw spinlock
Date: Sun, 13 Aug 2006 09:15:45 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20060810 935.775038000@suse.de> <200608130852.46300.ak@suse.de> <20060813000231.1ef1e21e.akpm@osdl.org>
In-Reply-To: <20060813000231.1ef1e21e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608130915.45114.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > What is the official portable interface to do a raw spinlock
> > if this one doesn't work?
> 
> I don't see a way, really.  Apart from going in and implementing it on the
> various architectures.

Hmpf. Maybe lockdep just needs a recursion check.

-Andi
