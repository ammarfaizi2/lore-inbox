Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132960AbRDESFt>; Thu, 5 Apr 2001 14:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132959AbRDESFj>; Thu, 5 Apr 2001 14:05:39 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:14608 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132886AbRDESFS>; Thu, 5 Apr 2001 14:05:18 -0400
Message-Id: <200104051804.f35I48s48040@aslan.scsiguy.com>
To: peter@rottengatter.de
cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx in Kernel 2.4.3 
In-Reply-To: Your message of "Wed, 04 Apr 2001 01:11:01 +0200."
             <E14kZx0-00079C-00@> 
Date: Thu, 05 Apr 2001 12:04:08 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Hi
>
>This driver seems to be pretty broken, the way it is. It does not compile.
>The new author, Justin T. Gibbs, has been careful in avoiding to mention
>his e-mail address in his code :-(

I actually don't believe in putting email address in code.  They become
stale far too easily.  If you ever want to find me, type my name
into a Yahoo search.  I did this today and was a little surprised at
the number of acurate hits. ;-)

>Hence the post to this list.

You should really check the archives before posting to LK.  This has
been discussed *a lot*.

The version that was released in 2.4.3 was stale weeks prior to
that final kernel cut.  I'm working on getting revised versions into
2.4.4.  If you want to upgrade to something newer, try the 6.1.9
release from here:

http://people.FreeBSD.org/~gibbs/linux/

Just be sure to configure the bus settle delay to 5000ms as the default
in that release causes a timeout.

You can also configure the aic7xxx_old driver.

--
Justin
