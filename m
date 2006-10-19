Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945971AbWJSOcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945971AbWJSOcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945920AbWJSOcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:32:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:26011 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161433AbWJSOcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:32:08 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
Date: Thu, 19 Oct 2006 16:26:10 +0200
User-Agent: KMail/1.9.3
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mingo@elte.hu, tglx@linutronix.de
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net> <1161266225.11264.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <45378A35.5020101@yahoo.com.au>
In-Reply-To: <45378A35.5020101@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191626.10662.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> An SMP kernel can boot on UP hardware, in which case I think
> num_possible_cpus() will be 1, won't it?

0 was a typo, i meant 1 for UP of course. 0 would be nonsensical.

-Andi
