Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSKXPk6>; Sun, 24 Nov 2002 10:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSKXPk5>; Sun, 24 Nov 2002 10:40:57 -0500
Received: from pasky.ji.cz ([62.44.12.54]:22009 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261376AbSKXPk5>;
	Sun, 24 Nov 2002 10:40:57 -0500
Date: Sun, 24 Nov 2002 16:48:08 +0100
From: Petr Baudis <pasky@ucw.cz>
To: GertJan Spoelman <kl@gjs.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updated Documentation/kernel-parameters.txt (resent, v3)
Message-ID: <20021124154808.GC25628@pasky.ji.cz>
Mail-Followup-To: GertJan Spoelman <kl@gjs.cc>,
	linux-kernel@vger.kernel.org
References: <20021123093600.GV25628@pasky.ji.cz> <200211231617.08772.kl@gjs.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211231617.08772.kl@gjs.cc>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sat, Nov 23, 2002 at 04:17:08PM CET, I got a letter,
where GertJan Spoelman <kl@gjs.cc> told me, that...
> Hello Petr,

Hello,

> Nice work.
> Can you add/change the comments for the mem and mem=exactmap parameters.
> The mem parameter doesn't behave in the same manner as it did before 
> 2.4.19/20, I think it changed somewhere in the 2.4.19-pre series.
> On an old Compaq 2500 with 320Mb memory the following line used to work :
> 	append="mem=320M"
> now I have to use:
> 	append="mem=exactmap mem=640K@0 mem=319M@1M"
> to get the kernel to see all the memory.
> On later kernels if I use mem=320M it only sees 16Mb, this is also true for 
> 2.5.44 (probably true for all the 2.5.x kernels) which I tried on that box.
> I don't know if it's only something specific for that box and maybe not 
> necessarily true for other systems which have to use the mem parameter.
> To me it looks like the mem parameter can now only be used to specify less 
> memory then the kernel actually recognizes.

Huh.. That could be some bug actually.. try to report this in a separate mail
with some attractive subject ;-).

> Also can you add how to use the mem=exactmap parameter, it says now that such 
> lines can be constructed based on BIOS output or other requirements, that 
> doesn't tell me how such a line should look like, I only found out how to use 
> it by searching through posts on lkml, maybe you can add the above append 
> lines as an example.

Thanks for the idea, done.

-- 
 
				Petr "Pasky" Baudis
.
weapon, n.:
        An index of the lack of development of a culture.
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
