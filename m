Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271613AbTGQWFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271617AbTGQWFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:05:54 -0400
Received: from [195.208.223.239] ([195.208.223.239]:11392 "EHLO
	pls.park.msu.ru") by vger.kernel.org with ESMTP id S271613AbTGQWFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:05:46 -0400
Date: Fri, 18 Jul 2003 02:20:43 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: typecast bug in sched.c bites reschedule_idle on alpha
Message-ID: <20030718022043.A5793@pls.park.msu.ru>
References: <20030717165139.B12164@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030717165139.B12164@hexapodia.org>; from adi@hexapodia.org on Thu, Jul 17, 2003 at 04:51:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 04:51:39PM -0500, Andy Isaacson wrote:
> Since asm-alpha/timex.h defines cycles_t as unsigned int, this
> comparison is always false.  Changing it to (cycles_t)-1 fixes the
> problem.

Nice catch, Andy. Thanks.

Ivan.
