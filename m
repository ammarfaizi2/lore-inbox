Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269175AbTGJKSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269174AbTGJKSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:18:39 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:2712 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S269173AbTGJKSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:18:38 -0400
Date: Thu, 10 Jul 2003 10:33:17 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: memset (was: Redundant memset in AIO read_events)
Message-ID: <20030710103317.D21655@devserv.devel.redhat.com>
References: <20030710100417.83333.qmail@web11801.mail.yahoo.com.suse.lists.linux.kernel> <1057832361.5817.2.camel@laptop.fenrus.com.suse.lists.linux.kernel> <p73smpepte1.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73smpepte1.fsf@oldwotan.suse.de>; from ak@suse.de on Thu, Jul 10, 2003 at 12:29:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 12:29:10PM +0200, Andi Kleen wrote:
> The problem is that the instruction that avoid write-allocate usually also force 
> the result out of cache. 

that's for the current implementation; rep stosl may get the WA-avoiding
behavior sometime without the negative cache effects.. someday maybe.
