Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUD2ApF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUD2ApF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUD2ApF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:45:05 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:38570
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262256AbUD2AoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:44:18 -0400
Date: Wed, 28 Apr 2004 20:50:59 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040428205059.A4563@animx.eu.org>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <40904A84.2030307@yahoo.com.au>; from Nick Piggin on Thu, Apr 29, 2004 at 10:21:24AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know. What if you have some huge application that only
> runs once per day for 10 minutes? Do you want it to be consuming
> 100MB of your memory for the other 23 hours and 50 minutes for
> no good reason?

I keep soffice open all the time.  The box in question has 512mb of ram. 
This is one app, even though I use it infrequently, would prefer that it
never be swapped out.  Mainly when I want to use it, I *WANT* it now (ie not
waiting for it to come back from swap)

This is just my oppinion.  I personally feel that cache should use available
memory, not already used memory (swapping apps out for more cache).

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
