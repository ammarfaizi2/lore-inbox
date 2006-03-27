Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWC0RkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWC0RkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWC0RkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:40:09 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:15620 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750813AbWC0RkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:40:08 -0500
Date: Mon, 27 Mar 2006 18:39:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Build system runs ld more often than needed
Message-ID: <20060327163930.GA12127@mars.ravnborg.org>
References: <20060327143848.3da1ac02.khali@linux-fr.org> <20060327140606.GA10649@mars.ravnborg.org> <20060327181728.a887c555.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327181728.a887c555.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 06:17:28PM +0200, Jean Delvare wrote:
 
> Given that composite targets each have an associated variable listing
> the parts they must be made of, maybe it is possible to use the same
> method for them? Or maybe it's too much hassle for the thin benefit,
> it's up to you.

Too much hassle considering the small benefit.
Especially since this will slow down the allmodconfig case even more
than today. The most time spent during a kernel build is in make
doing nothing other than checking prerequisites.

	Sam
