Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSCFXiz>; Wed, 6 Mar 2002 18:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSCFXiq>; Wed, 6 Mar 2002 18:38:46 -0500
Received: from Baa76.pppool.de ([213.7.170.118]:21120 "EHLO
	fastpage.beldesign.net") by vger.kernel.org with ESMTP
	id <S287134AbSCFXia>; Wed, 6 Mar 2002 18:38:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Yven Leist <leist@beldesign.de>
Organization: beldesign
To: "James M." <Dart@windeath.2y.net>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Date: Thu, 7 Mar 2002 00:34:13 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16iPsR-00052J-00@the-village.bc.nu> <3C8574C9.E1E4688C@windeath.2y.net>
In-Reply-To: <3C8574C9.E1E4688C@windeath.2y.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org, Michael Cohen <me@ohdarn.net>,
        Ingo Molnar <mingo@elte.hu>
Message-Id: <20020306233414.4A00D2ADE29@fastpage.beldesign.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 March 2002 02:45, James M. wrote:
> Alan Cox wrote:
> > >   I won't bring it up again, I'd love to think Rik, Alan and Ingo will
> > > keep working on performance patches for 2.4, but I wouldn't bet on it.
> >
> > I certainly will work on collating them - over time it will get less and
> > less of a win. A lot of the now very visible ones are really hard to fix
> > in 2.4 and will be 2.5 things (like block). And when you fix block you'll
> > find the next one and so on forever
>
> I'd love to see some performance patches. I've been watching my quake
> "timerefreshes" drop since 2.2. I've been using Ingo's scheduler patches
> on 2.4.17 with vast improvements in "smoothness" with what seems like an
> occasional block on big writes. I also tried 2.4.19-pre2-ac2(with
> scheduler merged), in that case the smoothness wasn't quite so apparent
> even with X niced to -10. There were also a lot of sound skips that
> didn't happen with 2.4.17/sched-K3. I attributed those to the renicing
> of X to smooth out the mouse.

I can really recommend 2.4.18-pre9-mjc2; it's _much_ better than 
2.4.18-pre8-mjc (I guess that's the difference between K2 and K3) and gives 
great interactive feel. I had it running continously for almost 20 days now 
and I've beaten it like hell, with vmware, wine, heavily threaded java apps, 
etc..  While doing really crazy things like "make -j 200" on my lowend athlon 
with 640MB RAM, the system remains 100% responsive, and this with a load well 
over 200 and more than 1000 processes!!
Where these "performance" enhancements are really getting invaluable, is when 
you do things like opening 1000 mp3 files in konqueror thinking you had 
"allow multiple instances" disabled in xmms... ; 
the stock 2.4 kernel just falls flat in such a situation, not even giving you 
the possibility to switch to the console to type "killall xmms" :-) 
so all these "performance" patches (especially the scheduler of course) do 
have invaluable benefits even for normal users with UP systems, and are 
therefore, IMHO of course, worth being integrated into 2.4 mainline.
cheers,
Yven

P.S: thanks for all the fantastic work :-)

-- 

Yven Johannes Leist - leist@beldesign.de
http://www.leist.beldesign.de

