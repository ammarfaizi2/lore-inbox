Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRHHU0i>; Wed, 8 Aug 2001 16:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269115AbRHHU02>; Wed, 8 Aug 2001 16:26:28 -0400
Received: from imladris.infradead.org ([194.205.184.45]:33033 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S267650AbRHHU0L>;
	Wed, 8 Aug 2001 16:26:11 -0400
Date: Wed, 8 Aug 2001 21:26:17 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Mark Atwood <mra@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <m3bslrv21e.fsf@flash.localdomain>
Message-ID: <Pine.LNX.4.33.0108080757060.12565-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark.

 > (apologies for splitting my reply into multiple pieces, but each
 > part covers different territory).

 >>  2. Multiple identical static interfaces.
 >>
 >>     At the moment, you are required to initialise the interfaces in
 >>     ascending order of their name in the modules.conf file.
 >>
 >>     I've dealt with this situation on several occasions, and never
 >>     found this to be a problem in any way.

 > Have you ever assembled a distribution that's going to be imaged
 > into several thousands to several tens of thousands of hardware
 > boxes, with evolving-into-the-future changes in hardware version
 > and changes in component suppliers?

I haven't personally, no, but RedHat, Caldera, SUSE, Debian and
Eridani all have, and (curiously enough) they all use the same basic
solution, although implemented in different ways. This is also the
solution implemented by the ifmap script I attached to my previous
email.

 > If Linux really wants to break into the appliance market, this
 > is going to be a bigger and bigger issue.

Agreed, but then, it appears to be an issue that has largely been
solved. The only part that may still need attention (I'm not up to
date on it, so can't say for sure) is the hotplug stuff.

Best wishes from Riley.

