Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315929AbSFDAJO>; Mon, 3 Jun 2002 20:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSFDAJN>; Mon, 3 Jun 2002 20:09:13 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:64528 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315929AbSFDAJN>;
	Mon, 3 Jun 2002 20:09:13 -0400
Date: Mon, 3 Jun 2002 17:06:49 -0700
From: Greg KH <greg@kroah.com>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] wait for devices to wake up before mounting root, but don't hang
Message-ID: <20020604000648.GS23446@kroah.com>
In-Reply-To: <Pine.LNX.4.44.0206031706400.11309-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 06 May 2002 19:43:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 05:31:03PM -0600, Lightweight patch manager wrote:
> Don't hang while waiting for root device to come up
> 
> Someone mentioned that USB devices etc. can't be used for root fs since 
> it's probably not yet available at boot time. This approach is broken, for 
> sure, but it's at least supposed to rescue a small part of the whole (if 
> you see a panic, you know something went atree).

Why only loop for 60 seconds?

I prefer the patch posted previously by Eric Lammerts that just loops
forever.  But that's just me :)

thanks,

greg k-h
