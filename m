Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264078AbTEJMuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 08:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTEJMuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 08:50:21 -0400
Received: from smtp.cogeco.net ([216.221.81.25]:64470 "EHLO fep1.cogeco.net")
	by vger.kernel.org with ESMTP id S264078AbTEJMuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 08:50:20 -0400
Date: Sat, 10 May 2003 09:09:51 -0400
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linking error in sounddrivers.o (2.4.20)
Message-ID: <20030510130951.GA502@dragon.homelinux.org>
References: <20030510012805.GA1037@dragon.homelinux.org> <20030510075220.GC31003@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510075220.GC31003@actcom.co.il>
User-Agent: Mutt/1.5.4i
From: Olivier Dragon <dragon@shadnet.shad.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 10:52:20AM +0300, Muli Ben-Yehuda wrote:
> On Fri, May 09, 2003 at 09:28:05PM -0400, Olivier Dragon wrote:
> > In the 2.4.20 kernel I have encountered a linking error happening in
> > sounddrivers.o. It happens with the following config file when doing
> > "make bzImage". It first happened with a ck6 patched kernel but I have
> > verified on two different computers (laptop running knoppix 3.2 and
> > desktop running Debian unstable) that it also happens in the unpatched
> > vanilla kernel.
> > 
> > http://dragon.homelinux.org/linux-2.4.20-ck6-config

Sorry about that. It's on my home machine and I turn it off at night to
save power (and money). It should be online all day.

> Does it still happen with 2.4.21-rc2? Also, could you please send me
> in private the .config? I get a 504 gateway error when trying to wget
> it. 

Actually now I get a different error, and it happens before the final
linkage step at which I used to get an error. But I think it might be an
error with GCC. There's a little blurb about submitting a bug report.

> > Gnu C                  3.2.3
> 
> That's a fairly experimental kernel for compiling kernels. You might
> want to stick with 2.95 for the time being. 

I've compiled quite a few kernels with a 3.2.x gcc and I've never run
into problems before. I'll change that to 2.95 and see what happens.

I've attached my .config to a private email following this one.

Thanks for your input,
-Olivier

-- 
          __-/|    ? ?     |\-__
     __--/  /  \   (^^)   /  \  \--__
  _-/   /   /   \ / ( )  /   \   \   \-_
 /  /   /  /     (   ^^ ~     \  \   \  \
 / Oli Dragon    dragon@shadnet.shad.ca \
/  Sfwr Eng IV   (  McMaster University  \
/  /  /     __--_ (   ) __--__     \  \  \
|  /  /  _/        \_ \_       \_  \  \  |
 \/  / _/            \_ \_       \_ \  \/
  \_/ /                -\_\        \ \_/
    \/                   -)         \/
                       *~
       ___--<****************>--___
      [http://dragon.homelinux.org/]
       ~~~--<****************>--~~~
