Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTECVqW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263437AbTECVqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:46:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:64529 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263436AbTECVqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:46:21 -0400
Date: Sat, 3 May 2003 23:58:24 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Thomas Backlund <tmb@iki.fi>
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Message-ID: <20030503215824.GA22461@alpha.home.local>
References: <3EB0413D.2050200@superonline.com> <200305020314.01875.tmb@iki.fi> <20030502130331.GA1803@alpha.home.local> <200305031546.57631.tmb@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305031546.57631.tmb@iki.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 03:46:57PM +0300, Thomas Backlund wrote:
 
> Oh man...
> I must have been sleeping when I posted that patch...

no problem, we all need some sleep at least once a week ;-)

> the correct line should AFAIK be:
> video_size = screen_info.lfb_width * screen_info.lfb_height * video_bpp;
> 
> (AFAIK we are calculating bits here, not bytes so the '/8' you used is 
> wrong... could you try without it, and let me know...)

OK, I was assuming that video_size was in bytes. I will retry without the /8.

> I'll be rebuilding and retesting my system today or tommorrow,
> but I wuold like to hear if it works for you...

I just come back home this evening, so let's say you'll get a feedback tomorrow
morning.

Regards,
Willy

