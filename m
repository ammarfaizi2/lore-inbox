Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKQUwC>; Fri, 17 Nov 2000 15:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129302AbQKQUvx>; Fri, 17 Nov 2000 15:51:53 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:15886 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129213AbQKQUvj>;
	Fri, 17 Nov 2000 15:51:39 -0500
Date: Fri, 17 Nov 2000 12:21:57 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: jani@virtualro.ic.ro
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] vgacon 
In-Reply-To: <Pine.LNX.4.10.10011172203550.4739-100000@virtualro.ic.ro>
Message-ID: <Pine.LNX.4.21.0011171215080.306-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2000 jani@virtualro.ic.ro wrote:

> 
> 	Hi James,
> 
> here is a patch for vgacon.c could you please check it?

Okay. Thank for for posting it not as a attachment. 

> 1) removes explicit 0 initialisation of statics

Those are fine. I already have in the ruby tree for the linux console
project.
 
> 2) removes an apparently unnecesary line in vgacon_scroll:
> 	as I see it scr_end is computed anyway after the if statement so
> no need to put it on the else branch.

Hum. Never noticed that one. I will try this part out just to make sure
their is no problem. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
