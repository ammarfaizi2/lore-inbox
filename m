Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSFFGkV>; Thu, 6 Jun 2002 02:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSFFGkU>; Thu, 6 Jun 2002 02:40:20 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:59404 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316824AbSFFGkT>;
	Thu, 6 Jun 2002 02:40:19 -0400
Date: Wed, 5 Jun 2002 23:37:28 -0700
From: Greg KH <greg@kroah.com>
To: Kees Bakker <kees.bakker@altium.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ov511 compilation failure 2.5.18 - struct urb has no next
Message-ID: <20020606063728.GA7200@kroah.com>
In-Reply-To: <15611.25585.983668.744210@koli.tasking.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 09 May 2002 04:44:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 02:41:21PM +0200, Kees Bakker wrote:
> Since 2.5.18 I'm getting compilation errors in ov511.c.
> ov511.c: In function `ov51x_init_isoc':
> ov511.c:3978: structure has no member named `next'
> ov511.c:3980: structure has no member named `next'
> 
> Struct member 'next' has been removed from struct urb.
> 
> Can I simply remove these lines that setup this 'ring'?

Sure, but odds are the driver will not work :)

See the linux-usb-devel archives for instructions on how to convert this
kind of driver if you're interested in doing so.

thanks,

greg k-h
