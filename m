Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265788AbUBRQeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266340AbUBRQeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:34:16 -0500
Received: from topaz.cx ([66.220.6.227]:1228 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S265788AbUBRQeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:34:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc3: USB subsystem wedged when USB keyboard is re-plugged
X-Newsgroups: linux.kernel
In-Reply-To: <1qfup-7RL-7@gated-at.bofh.it>
From: chip@pobox.com (Chip Salzenberg)
Organization: NASA Calendar Research
Message-Id: <E1AtUeB-0000aA-Qe@tytlal>
Date: Wed, 18 Feb 2004 11:34:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1qfup-7RL-7@gated-at.bofh.it> you write:
>  usb 2-2: new full speed USB device using address 5
>  usb 2-2: control timeout on ep0out
>
>And after that timeout, the USB subsystem seems totally stuck.
>Nothing I do provokes any further response.  (Kind of makes me wish
>I'd built the USB drivers as modules so I could unload and reload
>them.)

It's worse: rmmod uhci_usb hung, and nothing (including kill -9) could
unhang it.

Dammit.  I'd have thought that USB support would be safe on a
several-year-old IBM ThinkPad with fricking Intel chips.  *sigh*
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
