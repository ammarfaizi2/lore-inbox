Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVGMLOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVGMLOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVGMLNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:13:43 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:48332 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262687AbVGMLCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 07:02:40 -0400
Date: Wed, 13 Jul 2005 13:02:25 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lenz Grimmer <lenz@grimmer.com>
cc: Gijs Hillenius <gijs@hillenius.net>, Frank Sorenson <frank@tuxrocks.com>,
       hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Hdaps-devel] Re: Updating hard disk firmware & parking hard
 disk
In-Reply-To: <42D4EB21.1060305@grimmer.com>
Message-ID: <Pine.LNX.4.61.0507131259480.14635@yvahk01.tjqt.qr>
References: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com>
 <42CD7E0C.3060101@tuxrocks.com> <878y0bozf8.fsf@hillenius.net>
 <Pine.LNX.4.61.0507131208540.14635@yvahk01.tjqt.qr> <42D4EB21.1060305@grimmer.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Head parking while the system running is almost useless, since sooner or 
>> later, someone's going to write/read something.
>
>Correct, that's why we're discussing to freeze the request queue as well.

Sounds good (esp. for laptops/notebooks, which should preferably run "on RAM" 
as long as possible)

>But it suffers from the same fate - as soon as the disk receives a new
>request, it will spin up again.

In case of the SUSE bootscripts (and possibly others), some flush barriers are 
engaged, then the disk is spun down and immediately after the poweroff 
happens.

>So there is no gain, except that just
>parking the head without spinning down the spindle can be performed much
>faster.

What's the gain in parking the head manually if it's done anyway when the disk 
spins down (for whatever reason)?



Jan Engelhardt
-- 
