Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUBOHut (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUBOHut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:50:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:42653 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264310AbUBOHus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:50:48 -0500
Subject: Re: oops w/ 2.6.2-mm1 on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marc Heckmann <mh@nadir.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040215074140.GA3840@nadir.org>
References: <20040215074140.GA3840@nadir.org>
Content-Type: text/plain
Message-Id: <1076831383.6958.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 18:49:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-15 at 18:41, Marc Heckmann wrote:
> It happened while the machine was waking up from sleep. There were no
> UDF or ISO filesystems mounted at the time, in fact, there wasn't even
> a cd in the drive. The "autorun" process was running though (polls the
> cdrom drive, to see if a disc has been inserted...). There were some
> request timeouts on the cdrom drive (hdc) just before, it went to
> sleep (system was idle at the time, I wasn't even at home).
> 
> Here is the kernel output before and after the machine went to sleep. The Oops
> is at the bottom.

Looks like CD went berserk, and something didn't deal with the
error correctly... I don't know those code path in there
very well... Can you paste more of the ide-cd errors,
those are weird.

Ben.


