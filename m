Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRALWEn>; Fri, 12 Jan 2001 17:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRALWEd>; Fri, 12 Jan 2001 17:04:33 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:6406 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S132660AbRALWES>;
	Fri, 12 Jan 2001 17:04:18 -0500
Date: Fri, 12 Jan 2001 14:04:11 -0800
From: alex@foogod.com
To: Jordan <jordang@pcc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't build small enough zImage for floppy
Message-ID: <20010112140411.B5625@draco.foogod.com>
In-Reply-To: <3A5F7BA7.B2FF852B@pcc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A5F7BA7.B2FF852B@pcc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 03:48:23PM -0600, Jordan wrote:
> 1st, the Sony Vaio Z505HS appears to be an example of a machine which
> will not boot a bzImage correctly, compaining about the compression
> format.

I can say from experience that this is not the case.  In fact, the kernel 
binaries (RPM) I provide on my Z505 page (http://www.foogod.com/z505_linux) are 
bzImages (currently those are still test5, though I have used later ones on my 
own machine as well, and will probably be upgrading the page to 2.4.0 final 
eventually).  I will admit that I haven't tried booting them from a floppy.. 
perhaps this is where the problem lies.

The Z505HS does have a USB floppy drive, which is the only thing I can think 
of that's different from most other machines which might affect this, but I do 
know that that doesn't stop a 2.2 kernel from booting off of it (though there 
are problems accessing the floppy after the initial boot without USB drivers, 
of course)

I will look into building a 2.4.0 floppy-bootable kernel on my Z505 and see if 
I can reproduce the problems you're having.

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
