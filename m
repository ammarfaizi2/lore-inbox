Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVKFNzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVKFNzU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 08:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVKFNzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 08:55:20 -0500
Received: from THUNK.ORG ([69.25.196.29]:56220 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750838AbVKFNzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 08:55:20 -0500
Date: Sun, 6 Nov 2005 08:55:14 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051106135514.GA8020@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
	Kay Sievers <kay.sievers@vrfy.org>
References: <E1EYdMs-0001hI-3F@think.thunk.org> <436DD635.9030103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436DD635.9030103@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 11:08:53AM +0100, Jiri Slaby wrote:
> 
> >When I upgraded to 2.6.14 from 2.6.14-rc5, my X server failed to stop.  
> >Investigation revealed it was because my CorePointer was the Synaptics
> >driver, and the device corresponding to the Synaptics touchpad
> >(/dev/input/event2 on my laptop) was not being created.  Once I manually
> >created the device with the proper major/minor device numbers, X started
> >correctly.
> >
> >A comparison of "udevinfo -e" on 2.6.14-rc5 and 2.5.14 reveals the
> >following differences.  Was this change deliberate?  And can it be
> >reverted?
> 
> You should also write which version of udev do you use.

Oh, of course.  Version 0.071-1, from Debian unstable.

						- Ted
