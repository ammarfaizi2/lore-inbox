Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSGQUeP>; Wed, 17 Jul 2002 16:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSGQUeP>; Wed, 17 Jul 2002 16:34:15 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:6660 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316678AbSGQUeO>;
	Wed, 17 Jul 2002 16:34:14 -0400
Date: Wed, 17 Jul 2002 13:36:01 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@suse.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] agpgart changes for 2.5.26
Message-ID: <20020717203601.GB10047@kroah.com>
References: <20020717183615.GB9589@kroah.com> <20020717213056.I18170@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717213056.I18170@suse.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 19 Jun 2002 19:31:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 09:30:56PM +0200, Dave Jones wrote:
>  >  drivers/char/agp/via.c               |  151 +
> 
> Linus last comment mentioned via-agp.c, and the likes,
> which I did in my tree, but haven't put up a diff yet.
> I could dig those out for you, but you could probably
> 'mv' them faster than I can chunk up the diff into pieces.

But that would make:
	drivers/char/agp/via-agp.c
which is redundant, as that file does not compile to a separate module,
but gets linked to the larger agpgart.o like before.

Or at least that's why I chose the name, Linus if you like via-agp.c,
I'd be glad to change it.

thanks,

greg k-h
