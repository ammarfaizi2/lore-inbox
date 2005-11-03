Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVKCIEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVKCIEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVKCIEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:04:23 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:63776 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750817AbVKCIEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:04:23 -0500
Date: Thu, 3 Nov 2005 10:03:41 +0200
From: Gleb Natapov <gleb@minantech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hugh Dickins <hugh@veritas.com>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051103080341.GB22185@minantech.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au> <4368139A.30701@vc.cvut.cz> <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com> <1130965454.20136.50.camel@gaston> <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com> <1130967936.20136.65.camel@gaston> <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com> <1130970131.20136.73.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130970131.20136.73.camel@gaston>
X-OriginalArrivalTime: 03 Nov 2005 08:04:21.0819 (UTC) FILETIME=[32BBA8B0:01C5E04D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 09:22:10AM +1100, Benjamin Herrenschmidt wrote:
> Also, what do you suggest as a good threshold to use on the max amount
> of memory I can let the X server "pin" that way ? I was thinking it as
> equivalent to mlock, thus I could maybe hijack mm->locked_vm & use
> RLIMIT_MEMLOCK or is that too gross ?
> 
This is what infiniband does, so it should be good for you too.

--
			Gleb.
