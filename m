Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSAPXh2>; Wed, 16 Jan 2002 18:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287995AbSAPXhT>; Wed, 16 Jan 2002 18:37:19 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:7123 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S286343AbSAPXhJ>; Wed, 16 Jan 2002 18:37:09 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Date: Wed, 16 Jan 2002 15:36:53 -0800 (PST)
Subject: Re: CML2-2.1.3 is available
In-Reply-To: <20020116163144.D12306@thyrsus.com>
Message-ID: <Pine.LNX.4.40.0201161533090.25405-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, the way you worded the change report it sounded to many of us as if
you were making the autoprober mandatory for detecting the root
filesystem.

That's why it spawned so many messages like this (including one from me
yesterday)

you should have added something in the changelog entry that said that this
autoprobe only happened when you do an autoconfigure, as it is it implies
that is is for every variaty of make *config.

I understand why you are frustrated with the response, but it's not a case
of people having thick skulls it's a case of you leaving out critical info
from you changelog so people reading it without your mindset see it saying
something that you didn't mean.

remember most of us have no idea why the 'vitality' flag was there in the
first place so we can't imply a limit on the autoprober that is replacing
it.

 David Lang

 On Wed, 16 Jan 2002, Eric S. Raymond wrote:

> Date: Wed, 16 Jan 2002 16:31:44 -0500
> From: Eric S. Raymond <esr@thyrsus.com>
> To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
> Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
> Subject: Re: CML2-2.1.3 is available
>
> Horst von Brand <brand@jupiter.cs.uni-dortmund.de>:
> > > Release 2.1.3: Tue Jan 15 14:41:45 EST 2002
> > > 	* Resync with 2.4.18-pre3 and 2.5.2.
> > > 	* It is now possible to declare explicit saveability predicates.
> > > 	* The `vitality' flag is gone from the language.  Instead, the
> > > 	  autoprober detects the type of your root filesystem and forces
> > > 	  its symbol to Y.
> >
> > Great! Now I can't configure a kernel for ext3 only on an ext2 box. Keep it
> > up! As it goes, we can safely forget about CML2...
>
> Oh, nonsense.  You can do this just fine with any of the manual configurators.
> Now repeat after me, Horst:
>
> 	The autoconfigurator is *optional*, not required.
>
> 	The autoconfigurator is *optional*, not required.
>
> 	The autoconfigurator is *optional*, not required.
>
> 	The autoconfigurator is *optional*, not required.
>
> 	The autoconfigurator is *optional*, not required.
>
> 		:	:	:	:	:
>
> Please continue until insight penetrates your skull.  Thank you.
> --
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
>
> A human being should be able to change a diaper, plan an invasion,
> butcher a hog, conn a ship, design a building, write a sonnet, balance
> accounts, build a wall, set a bone, comfort the dying, take orders, give
> orders, cooperate, act alone, solve equations, analyze a new problem,
> pitch manure, program a computer, cook a tasty meal, fight efficiently,
> die gallantly. Specialization is for insects.
> 	-- Robert A. Heinlein, "Time Enough for Love"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
