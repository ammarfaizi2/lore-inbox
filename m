Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbQKQU4X>; Fri, 17 Nov 2000 15:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKQU4O>; Fri, 17 Nov 2000 15:56:14 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:3086 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129189AbQKQUz4>;
	Fri, 17 Nov 2000 15:55:56 -0500
Date: Fri, 17 Nov 2000 22:25:09 +0200 (EET)
From: <jani@virtualro.ic.ro>
To: James Simmons <jsimmons@suse.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] vgacon 
In-Reply-To: <Pine.LNX.4.21.0011171215080.306-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.10.10011172223480.4790-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 2) removes an apparently unnecesary line in vgacon_scroll:
> > 	as I see it scr_end is computed anyway after the if statement so
> > no need to put it on the else branch.
> 
> Hum. Never noticed that one. I will try this part out just to make sure
> their is no problem. 
> 

I've checked that and it works both on 2.2 and 2.4 but another test won't
hurt :-)

Jani.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
