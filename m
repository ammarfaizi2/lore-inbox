Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVGDOUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVGDOUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 10:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGDOUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 10:20:47 -0400
Received: from styx.suse.cz ([82.119.242.94]:35745 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261726AbVGDOLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 10:11:50 -0400
Date: Mon, 4 Jul 2005 16:11:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-1?Q?C=F4t=E9?= Alexandre <alialex@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: psmouse, proto
Message-ID: <20050704141149.GA16388@ucw.cz>
References: <20050704152014.06424fe4@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050704152014.06424fe4@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 03:20:14PM +0200, Côté Alexandre wrote:

> kernel : 2.6.11 from kernel-tree 2.6.11-7 on debian  sid
> 
> psmouse module install automatically when booting the system (nothing write in /etc/modules, don't know why it's now automatically install) and dmesg says
> input: ImExPS/2 Logitech explorer mouse on isa0060/serio1
> 
> everythings good
> but the middle button (button 2) doesn't work (nothing with xev)
> 
> if I rmmod psmouse and then
> modprobe psmouse proto=exps
> 
> then dmesg says
> 
> input: ImExPS/2 Generic explorer mouse on isa0060/serio1
> 
> and then my mouse works good, the button 2 works.
> 
> I send this just for information.
> 
> PS: it looks like the serio1 is my keyboard and that the mouse is on serio0.
 
What mouse is it? (Manufacturer / model?)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
