Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266375AbUKAPGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266375AbUKAPGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269055AbUKAPGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:06:46 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:55947 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S268115AbUKAPGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 10:06:11 -0500
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: [OT] Re: code bloat [was Re: Semaphore assembly-code bug]
Date: Mon, 1 Nov 2004 10:09:41 -0500
User-Agent: KMail/1.7
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <418550C1.1060203@comcast.net> <20041101154853.6b393f8a.diegocg@teleline.es>
In-Reply-To: <20041101154853.6b393f8a.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411010909.41482.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 November 2004 08:48, Diego Calleja wrote:

> Sadly it's true, but in the other hand I haven't seen something like
> gnome/kde which don't eats lots of resources (mac os x and XP are not
> better, beos was better they say)

Part of the problem with KDE is the QT library underneath it all.  QT 4 is 
supposed to be leaner and faster.  The KDE folks seem to be trying pretty 
hard to reduce bloat whenever possible.  But when you have software that's 
expected to have the kitchen sink, it's especially challenging to reduce the 
footprint while keeping all of the functionality.

I use openbox on my laptop.  It's nothing near KDE in terms of functionality, 
but it also runs reasonably snappy on a Pentium 266, so I can't complain too 
much.

So far I'm pretty glad that the linux kernel developers have resisted putting 
graphics calls and routines into the kernel.  It slows things down a bit, but 
I'd like to think you guys have learned from MS's mistakes.  IMO one of the 
biggest mistakes they ever made was to pollute the NT kernel with the 
graphics subsystem.  That said, FBUI looks like an interesting add-on 
project.

Enough of my off topic ranting...

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
