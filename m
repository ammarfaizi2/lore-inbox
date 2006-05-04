Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWEDMpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWEDMpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 08:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWEDMpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 08:45:18 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:51033 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932299AbWEDMpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 08:45:17 -0400
Message-ID: <4459F757.8070408@tls.msk.ru>
Date: Thu, 04 May 2006 16:45:11 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: cdrom: a dirty CD can freeze your system
References: <200605041232.k44CWnFn004411@wildsau.enemy.org>
In-Reply-To: <200605041232.k44CWnFn004411@wildsau.enemy.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:
> good day,
> 
> kernel-version: 2.6.16.13 preemptible
> 
> I've been experimenting with damaged CDs this day. I observed that
> a dirty or (partly) unreadable CD will (1) block the process which is
> trying to read from the CD - it will be in state "D" - uninterruptible
> sleep and (2) sometimes(?) probably freeze your system such that even
> a manual reboot wont work (e.g., because it's not possible to log in, or
> keystrokes are no longer accepted) and a power-cycle is required.
> 
> the uninterruptible process will force a reboot - it wont go away.

It's worse than that.  See http://marc.theaimsgroup.com/?t=114003595500002&r=1&w=2
and other similar reports.  So far, noone cares it seems (for several years already).

/mjt
