Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWBKWWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWBKWWr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWBKWWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:22:47 -0500
Received: from diomedes.noc.ntua.gr ([147.102.222.220]:36591 "EHLO
	diomedes.noc.ntua.gr") by vger.kernel.org with ESMTP
	id S1750760AbWBKWWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:22:46 -0500
Date: Sun, 12 Feb 2006 00:18:34 +0200 (EET)
From: "Theodoros V. Kalamatianos" <thkala@softlab.ece.ntua.gr>
To: Jan Merka <merka@highsphere.net>
cc: suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel]
 Re: [ 00/10] [Suspend2] Modules support.)
In-Reply-To: <200602111136.56325.merka@highsphere.net>
Message-ID: <Pine.LNX.4.64.0602120013570.13246@rhama.deepcore.ngn>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
 <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz>
 <200602111136.56325.merka@highsphere.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2006, Jan Merka wrote:

> On Friday 10 February 2006 18:35, Pavel Machek wrote:
>> Anyway, it means that suspend is still quite a hot topic, and that is
>> good. (Linus said that suspend-to-disk is basically for people that
>> can't get suspend-to-RAM to work, and after I got suspend-to-RAM to
>> work reliably here, I can see his point).
>
> I strongly disagree. I got suspend-to-RAM to work but its utility is seriously
> limited by battery capacity. For example, on my laptop (Sony VGN-B100B) with
> 1.5GB of RAM, a fully charged battery is drained in about 18 hours if the
> laptop was suspended to RAM.
>
> Yes, for a few hours suspend-to-RAM is convenient but suspend-to-disk is
> _reliable_ and _safe_.

People with dual-boot systems (before someone starts screaming, I know 
people that dual-boot Linux as well for testing/development reasons) can 
also benefit from STD. You just put Linux to sleep, boot your testing OS,
and when you are done just resume your normal Linux system and continue 
working. Before I got a second PC, suspend (swsusp then) used to be a 
savior for kernel driver testing...
