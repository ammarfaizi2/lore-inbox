Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWC0KMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWC0KMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWC0KMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:12:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64407 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750842AbWC0KMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:12:39 -0500
Date: Mon, 27 Mar 2006 12:12:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: finally solve mysqld problem
Message-ID: <20060327101210.GF14344@elf.ucw.cz>
References: <200602051321.55519.rjw@sisk.pl> <20060325183817.GM4053@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325183817.GM4053@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 25-03-06 19:38:17, Adrian Bunk wrote:
> On Sun, Feb 05, 2006 at 01:21:54PM +0100, Rafael J. Wysocki wrote:
> 
> > Hi,
> 
> Hi Rafael,
> 
> > This patch from Pavel moves userland freeze signals handling into
> > more logical place.  It now hits even with mysqld running.
> >...
> 
> I've seen this patch has been included in Linus' tree.
> 
> What exactly was this "mysqld problem" problem, and more specifically, 
> is this patch 2.6.16.2 material?

Suspend failed with mysqld running (for a *long* time). I believe this
patch would be too risky for 2.6.16.2.
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
