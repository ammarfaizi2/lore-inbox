Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSFBOyY>; Sun, 2 Jun 2002 10:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317193AbSFBOyX>; Sun, 2 Jun 2002 10:54:23 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:59910 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317192AbSFBOyW>;
	Sun, 2 Jun 2002 10:54:22 -0400
Date: Sun, 2 Jun 2002 16:56:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Thunder from the hill <thunder@ngforever.de>,
        Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: KBuild 2.5 Impressions
Message-ID: <20020602165643.A1940@mars.ravnborg.org>
In-Reply-To: <Pine.LNX.4.44.0206012349360.671-100000@age.cs.columbia.edu> <Pine.LNX.4.44.0206020139510.29405-100000@hawkeye.luckynet.adm> <20020602160357.A1726@mars.ravnborg.org> <E17EWV7-0000Pv-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2002 at 04:38:33PM +0200, Daniel Phillips wrote:
> You mean, fixing the bugs you introduced by trying to add it piecemeal?
> How about breaking it up where it makes sense to do so, and not breaking
> it up where it's silly.
Can we agree that it makes sense to add features one-by-one when
they are independent?

If thats the case then it is a simple matter of looking through the
features already present in kbuild-2.5.
Then to compare those features with the work done by Kai.
If the feature is worth it and can be introduced without the core,
then introduce it in kbuild-2.4.
This will make this specific feature visible to many people, and 
those who feel against it can speak up.

> If you have a specific suggestion about which part should be broken out,
> feel free to provide details.
I already gave a list of features that could be broken out. Do you request
more information than that?

I already submitted 4 patches digged out from kbuild-2.5, one of them
introducing a bug. The bug was present in kbuild-2.5!
This bug was easy to spot since the patch was selfcontained, but
within several thousands of kbuild-2.5 source lines it would have been missed
most probarly.

	Sam
