Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTJCPUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 11:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTJCPUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 11:20:15 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:18612 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263762AbTJCPUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 11:20:12 -0400
Subject: Re: [PATCH] macintosh/adbhid.c REP_DELAY fix (was Re: 2.6.0-test5
	- stuck keys on iBook)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Figureau <brice@tincell.com>
Cc: cliff white <cliffw@osdl.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1065166822.7878.2.camel@localhost>
References: <20030930143149.4930ec9c.cliffw@osdl.org>
	 <1065166822.7878.2.camel@localhost>
Content-Type: text/plain
Message-Id: <1065194389.23225.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 03 Oct 2003 17:19:49 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-03 at 09:40, Brice Figureau wrote:
> Hi Cliff,
> 
> On Tue, 2003-09-30 at 23:31, cliff white wrote:
> > Kernel version: latest from ppc.bkbits.net/linuxppc-2.5
> >
> > Symptom: keyboard diarrhea - single keypress == 3-7 characters.
> 
> Here is a patch that fixes the keyboard problem. The input layer
> REP_DELAY (and REP_PERIOD) were changed from jiffies to ms but the adb
> was not updated accordingly.
> 
> I hope this will help you.

Thanks, I'll test & commit.

Ben.


