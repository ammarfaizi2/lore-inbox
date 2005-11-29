Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVK2Wlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVK2Wlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 17:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVK2Wlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 17:41:36 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:35213 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932440AbVK2Wlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 17:41:35 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc3
Date: Tue, 29 Nov 2005 23:42:35 +0100
User-Agent: KMail/1.8.3
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <200511292247.09243.rjw@sisk.pl>
In-Reply-To: <200511292247.09243.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511292342.36228.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update:

On Tuesday, 29 of November 2005 22:47, Rafael J. Wysocki wrote:
> On Tuesday, 29 of November 2005 05:11, Linus Torvalds wrote:
> > 
> > I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
> > diffstats appended.
> 
> Hangs solid on boot on dual-core Athlon64.  No details yet, but I'm working
> on them.  I wonder if anyone else is seeing this.

The problem is caused by the ehci_hcd driver and fixed by the David
Brownell's ehci-hang-fix.patch that's already in -mm.

Thanks,
Rafael

