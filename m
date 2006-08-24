Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWHXTqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWHXTqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbWHXTqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:46:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6925 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751329AbWHXTqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:46:35 -0400
Date: Thu, 24 Aug 2006 19:46:24 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060824194623.GB4539@ucw.cz>
References: <fa.nURugTWtyfQKAbvUB0DbTkmyPAY@ifi.uio.no> <44E28989.1010904@shaw.ca> <20060815212656.4eb260f3.akpm@osdl.org> <20060816042924.GA30115@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816042924.GA30115@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
>  > > 
>  > > Warnings and an oops on suspend to disk:
>  > > 
>  > > http://www.roberthancock.com/oops1.jpg
>  > > http://www.roberthancock.com/oops2.jpg
>  > > http://www.roberthancock.com/oops3.jpg
>  > > http://www.roberthancock.com/oops4.jpg
>  > > http://www.roberthancock.com/oops5.jpg
>  > > http://www.roberthancock.com/oops6.jpg
>  > > http://www.roberthancock.com/oops7.jpg
>  > > http://www.roberthancock.com/oops8.jpg
>  > > 
>  > > Sleeping function called from invalid context in acpi
>  > 
>  > Yes.  It appears that we've decided to release 2.6.18 with this feature.
> 
> Well it's not like it'd be a regression. That thing has been there
> for over a year now at least in one form or other.

I believe that we had it fixed at one point...?
						Pavel
-- 
Thanks for all the (sleeping) penguins.
