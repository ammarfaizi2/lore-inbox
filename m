Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313304AbSEETFI>; Sun, 5 May 2002 15:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSEETFH>; Sun, 5 May 2002 15:05:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16915 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313304AbSEETFG>; Sun, 5 May 2002 15:05:06 -0400
Date: Sun, 5 May 2002 21:05:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: hugang <gang_hu@soul.com.cn>
Cc: jdike@karaya.com, glonnon@ridgerun.com, Pavel Machek <pavel@suse.cz>,
        seasons@fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATH] Port software to UML.
Message-ID: <20020505190508.GA2526@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020505214819.19cb9a86.gang_hu@soul.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   Now I try port software to UML(user mode linux).
> This patch is for the 2.4.18 + uml-patch-2.4.18-22.

Hmm, I had same idea myself few hours ago (but no time :-( ).
> 
> -- Now the patch is make the kernek can suspend, BUT can not resume.
> 
> Here is the error message.
> 
> Ther problem in bread. I check the ubd drivers, in ubd_user.c the do_io is lseek64 the descriptor is error, The right descriptor is swap.a, But in here it is an socket. I think problem possbile in ubd, because in ide disk it can works fine.
> 

Swap file should not be a socket, right?
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
