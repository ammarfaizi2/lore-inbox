Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbTGKBHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbTGKBHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:07:20 -0400
Received: from ns.suse.de ([213.95.15.193]:7694 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266570AbTGKBGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:06:34 -0400
Date: Fri, 11 Jul 2003 03:20:29 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix x86-64 FIOQSIZE compile error in 2.4.22-pre4
Message-ID: <20030711012029.GA12671@wotan.suse.de>
References: <200307110112.h6B1CEfR006510@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307110112.h6B1CEfR006510@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 03:12:14AM +0200, Mikael Pettersson wrote:
> 2.4.22-pre4 added a FIOQSIZE ioctl but the x86-64 ioctls.h
> wasn't updated: the result is a compile error is fs/ somewhere
> (sorry I forgot exactly where). Fix below.

Thanks. I will include it in the next update. Haven't tried pre4 yet.

I've carried similar patches for a long time in other trees though.

-Andi
