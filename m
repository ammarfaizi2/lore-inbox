Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130627AbRBAPWq>; Thu, 1 Feb 2001 10:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130626AbRBAPWg>; Thu, 1 Feb 2001 10:22:36 -0500
Received: from datafoundation.com ([209.150.125.194]:14346 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S130609AbRBAPWW>; Thu, 1 Feb 2001 10:22:22 -0500
Date: Thu, 1 Feb 2001 10:22:19 -0500 (EST)
From: John Jasen <jjasen@datafoundation.com>
To: William Knop <w_knop@hotmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Modules and DevFS
In-Reply-To: <F204tAEHLB8TrBHxvZ900001de6@hotmail.com>
Message-ID: <Pine.LNX.4.30.0102011021520.31149-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, William Knop wrote:

> >One thing that I've noticed with devfs is that all the old-style names are
> >symlinks.
>
> Hmm... I have no symlinks until the module loads. Therefore X sees no
> /dev/input/mouse, doesn't ask the kernel for it, the kernel doesn't load the
> module, and DevFS doesn't add the /dev entry. There's got to be an easy way
> around this. Perhaps it has already been implimented, but I haven't been
> able to get anything to work well (manual loading for me).

change your XF86Config file to point to /dev/psaux


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
