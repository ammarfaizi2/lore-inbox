Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSFBSXp>; Sun, 2 Jun 2002 14:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSFBSXo>; Sun, 2 Jun 2002 14:23:44 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:61705 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316869AbSFBSXn>;
	Sun, 2 Jun 2002 14:23:43 -0400
Date: Sun, 2 Jun 2002 20:26:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Thunder from the hill <thunder@ngforever.de>,
        Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: KBuild 2.5 Impressions
Message-ID: <20020602202633.A2396@mars.ravnborg.org>
In-Reply-To: <Pine.LNX.4.44.0206012349360.671-100000@age.cs.columbia.edu> <E17EWV7-0000Pv-00@starship> <20020602165643.A1940@mars.ravnborg.org> <E17EX5v-0000Qd-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2002 at 05:16:34PM +0200, Daniel Phillips wrote:
> > Can we agree that it makes sense to add features one-by-one when
> > they are independent?
> 
> Oh absolutely, and have you looked at the current factoring?
> 
>    http://marc.theaimsgroup.com/?a=102296100300003&r=1&w=2
> 
> This is still being improved, of course.
I have looked at the above factoring, which was only a file factoring,
neither bug-fix factoring, nor feature factoring.
IMHO this is not the way kbuild-2.5 ever get included in the kernel.

> What I'd suggest is: import
> enough of kbuild 2.5 to support the feature (in some case nothing
> needs to be imported), then make it work also for old kbuild (in
> some cases that will require no work.  This I'd call cooperation,
> which would look good on everybody involved.
Again wrong approah. Extend kbuild-2.4 with the features, tweak them until
they actually meet the requirements and then on to the next step.
Obviously the dependency step is huge, but the point is that there is
steps before and after this.

	Sam
