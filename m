Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbTECP65 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 11:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTECP65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 11:58:57 -0400
Received: from granite.he.net ([216.218.226.66]:11530 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261175AbTECP64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 11:58:56 -0400
Date: Sat, 3 May 2003 08:16:59 -0700
From: Greg KH <greg@kroah.com>
To: Riley Williams <Riley@Williams.Name>
Cc: Balram Adlakha <b_adlakha@softhome.net>, linux-kernel@vger.kernel.org
Subject: Re: wrong screen size with fbcon [2.5.68]
Message-ID: <20030503151659.GA16996@kroah.com>
References: <20030503003836.GA1071@kroah.com> <BKEGKPICNAKILKJKMHCAEEDKCKAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEGKPICNAKILKJKMHCAEEDKCKAA.Riley@Williams.Name>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 03:05:04PM +0100, Riley Williams wrote:
> Hi Greg.
> 
>  >> I posted about this when 2.5.68 was released but very few people
>  >> responded. While using the framebuffer console driver, I seems
>  >> that the screen is set to something like 1024x775 instead of
>  >> 1024x768. I cannot see the bottom of my screen that is...
>  >>
>  >> I just checked the latest bk taken from kernel.org and still
>  >> hasn't been fixed. The fb console was working perfectly till
>  >> 2.5.67.
>  >>
>  >> If it is of any relevance, I'm using an NVIDIA tnt2 card. Has
>  >> nobody noticed this problem?
> 
>  > I have, and posted pretty much the same report a few weeks ago.
>  > Time to go write up a bug in bugzilla.kernel.org...
> 
> The probable response will be WONTFIX on the grounds that the NVIDIA
> driver is a binary only driver and, as such, can't be fixed...

No, I'm using the VESA framebuffer driver that is in the kernel.  This
same thing happens on two different machines with two different video
cards. 

No binary only driver for me, don't you think I would know better?  :)

thanks,

greg k-h
