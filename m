Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUHJLmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUHJLmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUHJLmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:42:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49100 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264389AbUHJLmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:42:01 -0400
Date: Tue, 10 Aug 2004 13:00:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kevin Fenzi <kevin-kernel@scrye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pmdisk/swsusp 2.6.8-rc2-mm1 success
Message-ID: <20040810110003.GB467@openzaurus.ucw.cz>
References: <20040728211616.A6C36894D7@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728211616.A6C36894D7@voldemort.scrye.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The status display is very ugly. It prints cryptic items and lots of
> random .... and | that don't mean much to me. ;) 
> It would be nice if it could just give a % age complete or a spinning
> cursor to indicate its doing something. 
> 
> It's a good deal slower than software suspend2. Is there any plans to
> add in the LZO compression that software suspend2 uses? 

Is it *always* slow? It is slow for some people and I'm searching
for reproducible testcase...

> On resume there is a inital part where the display just sits there. I
> wasn't sure if it was hung or not, but it was just calculating. It
> would be nice if it could provide a 'this might take a while' or a
> spinning cursor or status bar to let you know it's not dead. 

Hmm, not sure which part is that... I do not see delays
bigger than 5 seconds...

> There aren't any bootup messages to indicate that it's
> available. Would it be possible to add something like: 
> swsusp1: will use /dev/hda2 to resume. 
> swsusp1: /dev/hda2 is regular swap space. Continuing to boot. 

One line should be enough... 
				Pavel
				
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

