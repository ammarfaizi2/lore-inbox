Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVHHWJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVHHWJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVHHWJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:09:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39888 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932307AbVHHWJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:09:46 -0400
Date: Tue, 9 Aug 2005 00:09:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Task notifier against mm: Implement todo list in task_struct
Message-ID: <20050808220941.GB1821@elf.ucw.cz>
References: <Pine.LNX.4.62.0507291328170.5304@graphe.net> <Pine.LNX.4.62.0507291332100.5304@graphe.net> <20050730112241.GA1830@elf.ucw.cz> <Pine.LNX.4.62.0507300843100.24809@graphe.net> <20050730161007.GA1885@elf.ucw.cz> <Pine.LNX.4.62.0507300916170.25259@graphe.net> <20050730162223.GB1885@elf.ucw.cz> <Pine.LNX.4.62.0508011141440.5458@graphe.net> <20050808094301.GA1784@elf.ucw.cz> <Pine.LNX.4.62.0508080848290.19159@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508080848290.19159@graphe.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Got a new suspend patchsset at 
> > > 
> > > ftp://ftp.kernel.org:/pub/linux/kernel/people/christoph/suspend/2.6.13-rc4-mm1
> > > 
> > > Check the series file for the sequence of patches.
> > 
> > Something still goes very wrong after first resume. It seems to work
> > ok for few seconds, then console switch takes 10 seconds to react and
> > cursor stops blinking, and then it is dead.
> 
> Could you get me some more details as to what is happening?
> 
> This means it:
> 
> 1. suspends correctly.
> 
> 2. resumes.
> 
> 3. Then after 10 seconds there is a crash?

More or less. It was more like:

then after 10 seconds machine freezes. You press Alt-F1 to switch
consoles, nothing happens for 3 seconds, then it switches. [Seems like
some problems with console kernel thread to me... Using vesafb and
acpi.]
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
