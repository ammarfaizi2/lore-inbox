Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSFKAl6>; Mon, 10 Jun 2002 20:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSFKAly>; Mon, 10 Jun 2002 20:41:54 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:33800 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316599AbSFKAlw>;
	Mon, 10 Jun 2002 20:41:52 -0400
Date: Mon, 10 Jun 2002 17:38:09 -0700
From: Greg KH <greg@kroah.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 5/19
Message-ID: <20020611003809.GG5202@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048D5A.1030103@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 13 May 2002 22:08:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 01:28:26PM +0200, Martin Dalecki wrote:
> Fix improper __FUNCTION__ usage in st680 driver code,
> cdc-ether.c. Fix namespace clash in cdc-ether.h

What namespace clash?  It builds just find for me.

And don't try to clean up the __FUNCTION__ mess in the USB drivers right
now, I'll do them all at once when we have to move up to a newer version
of gcc for some other reason.

thanks,

greg k-h
