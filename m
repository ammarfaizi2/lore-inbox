Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVKXXYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVKXXYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVKXXYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:24:45 -0500
Received: from mx1.rowland.org ([192.131.102.7]:41992 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751392AbVKXXYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:24:44 -0500
Date: Thu, 24 Nov 2005 18:24:42 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] USB: Fix USB suspend/resume crasher (#2)
In-Reply-To: <1132873186.26560.487.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0511241823230.17577-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2005, Benjamin Herrenschmidt wrote:

> This patch closes the IRQ race and makes various other OHCI & EHCI code
> path safer vs. suspend/resume.
> I've been able to (finally !) successfully suspend and resume various
> Mac models, with or without USB mouse plugged, or plugging while asleep,
> or unplugging while asleep etc... all without a crash.
> 
> Alan, please verify the UHCI bit I did, I only verified that it builds.
> It's very simple so I wouldn't expect any issue there. If you aren't
> confident, then just drop the hunks that change uhci-hcd.c

It looks fine.  If there are any problems, I'll let you know.

Alan Stern

