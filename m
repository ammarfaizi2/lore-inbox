Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313287AbSDDR4i>; Thu, 4 Apr 2002 12:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313288AbSDDR42>; Thu, 4 Apr 2002 12:56:28 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:21258 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313287AbSDDR4K>;
	Thu, 4 Apr 2002 12:56:10 -0500
Date: Thu, 4 Apr 2002 09:54:38 -0800
From: Greg KH <greg@kroah.com>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.7-dj3 - BUG & PATCH
Message-ID: <20020404175438.GG15918@kroah.com>
In-Reply-To: <20020404054923.A28437@suse.de> <20020404172238.62bf1d41.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 07 Mar 2002 14:45:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 05:22:38PM +0200, Sebastian Droege wrote:
> 
> I don't see any differences between 2.5.7-dj3 and 2.5.8-pre1 which can
> cause such error but the patch at the bottom solves it ;) Maybe
> someone can explain me why 2.5.8-pre1 compiles without the #ifdefs
> (with CONFIG_USB_HIDINPUT set and unset) and not in 2.5.7-dj3
> 
> With this patch my mouse and keyboard work again

Wrong patch, do not apply.  Well, half of the patch is wrong.  The
Config.in part is correct.  I'm guessing that the changes made in
2.4.8-pre1 to include/hiddev.h didn't make it into -dj3

Try seeing if adding that patch to the -dj tree fixes things for you.
If you still have problems, let me know and I'll try to figure it out.

thanks,

greg k-h
