Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSGHMhq>; Mon, 8 Jul 2002 08:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSGHMhp>; Mon, 8 Jul 2002 08:37:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62473 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316882AbSGHMho> convert rfc822-to-8bit; Mon, 8 Jul 2002 08:37:44 -0400
Message-ID: <3D298823.6040503@evision-ventures.com>
Date: Mon, 08 Jul 2002 14:40:03 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Brad Hards <bhards@bigpond.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC patch] Config re-org for storage devices
References: <200207082219.08470.bhards@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Brad Hards napisa³:
> I'm looking at usability cleanups on the configuration files ([Cc]onfig.in).
> 
> The main concepts are to keep related menu entries together without excessive
> resort to 'misc" and "general", and to keep xconfig and menuconfig entries to
> about a screenful. Those two concepts are sometimes contradictory....
> 
> The current focus is on the various mass storage drivers. I plan to group them
> all under a single menu entry (done for i386, easily extensible to other arch,
> except for sparc of course). The main changes are pulling the parallel port
> IDE stuff out of the rest of block to a separate menu item, pulling QIC02 and
> ftape out of the rest of char(!) and some (fairly dubious) changes to the way
> IDE configuration works.
> 
> Find below a draft patch for comment. Even fflames would be good - at least it
> would show people read this stuff.

Looked thorugh it. No need for flaming found. The IDE changes are
fine. However a "subsystem by subsystem" patch approach would
help, since I could for example pull the stuff I care about out
and test it without regression concerns for the other things.

