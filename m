Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUFVWZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUFVWZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbUFVWXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 18:23:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:34731 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266014AbUFVWVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 18:21:25 -0400
Subject: Re: [PATCH][2.6.7-mm1] perfctr ppc32 update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <16600.45126.425726.174463@alkaid.it.uu.se>
References: <200406212014.i5LKElHD019224@alkaid.it.uu.se>
	 <1087928274.1881.4.camel@gaston>
	 <16600.37372.473221.988885@alkaid.it.uu.se>
	 <1087935661.1855.10.camel@gaston>
	 <16600.39256.669322.177553@alkaid.it.uu.se>
	 <1087939194.1839.13.camel@gaston>
	 <16600.45126.425726.174463@alkaid.it.uu.se>
Content-Type: text/plain
Message-Id: <1087942472.1855.75.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 17:14:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-22 at 17:18, Mikael Pettersson wrote:

> So can I assume constant TB speed? In that case I don't
> really care about core speed changes.

So far, tb speed is constant yes, I haven't seen a case where it's
not. What we should really do is to expose the tb speed to userspace
generically on ppc, possibly via /proc/cpuinfo like we do on ppc64,
it definitely has other uses than just profiling.

Ben.


