Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbULEXvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbULEXvU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbULEXvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:51:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:34774 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261426AbULEXvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:51:15 -0500
Subject: Re: [linux-pm] swsusp-bigdiff: power-managment changes that are
	waiting in my tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, mjg59@srcf.ucam.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20041205233230.GC1490@elf.ucw.cz>
References: <20041205214910.GA1293@elf.ucw.cz>
	 <1102284611.11763.97.camel@gaston> <20041205232440.GA1490@elf.ucw.cz>
	 <1102289413.11761.110.camel@gaston>  <20041205233230.GC1490@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 06 Dec 2004 10:50:45 +1100
Message-Id: <1102290645.11763.118.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 00:32 +0100, Pavel Machek wrote:
> Hi!
> 
> > > We need to add pm_message_t to resume, I agree about that, but yes, it
> > > would be quite bad if I added this, too.
> > > 
> > > All changes I'm doing are "break nothing", because pm_message_t is
> > > typedefed to u32 for now. Therefore they can be safely merged in any
> > > order etc...
> > 
> > Hrm... adding it to all resume, if done at once, won't break anything
> > since nobody uses it yet.
> 
> "Done at once" is going to be a problem. I do not have that kind of
> magical sed skills yet ;-).

Me neither ... but I though you did :)

Ben.


