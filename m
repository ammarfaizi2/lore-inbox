Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932085AbWFFEhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWFFEhU (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 6 Jun 2006 00:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWFFEhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 00:37:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8400
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932085AbWFFEhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 00:37:18 -0400
Date: Mon, 05 Jun 2006 21:36:55 -0700 (PDT)
Message-Id: <20060605.213655.41876860.davem@davemloft.net>
To: ak@suse.de
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
From: David Miller <davem@davemloft.net>
In-Reply-To: <p73ac8w0wju.fsf@verdi.suse.de>
References: <447E3846.1060302@shaw.ca>
	<447E7CF5.8020401@mbligh.org>
	<p73ac8w0wju.fsf@verdi.suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: 02 Jun 2006 10:52:05 +0200

> "Martin J. Bligh" <mbligh@mbligh.org> writes:
> > 
> > All sounds very sensible ... but not sure why -mm would hit it all the
> > time, and never mainline ...
> 
> You can use memeat.c to test the machine with other kernels.
> It tends to find such problems reliably. Let it run for some time
> 
> http://www.firstfloor.org/~andi/memeat.c

Wouldn't it be more useful for this program to use LowTotal instead of
LowFree?  It didn't grind my sparc64 machine much until I changed it
like that. :)

