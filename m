Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287940AbSAPVuT>; Wed, 16 Jan 2002 16:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289008AbSAPVuJ>; Wed, 16 Jan 2002 16:50:09 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:46523 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S287940AbSAPVtx>; Wed, 16 Jan 2002 16:49:53 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Adam Kropelin" <akropel1@rochester.rr.com>
Subject: Re: Rik spreading bullshit about VM
Date: Wed, 16 Jan 2002 22:49:49 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020116215003Z287940-13996+7210@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> Andrea Arcangeli wrote:
> <snip>
> >I don't have a single bugreport about the current 2.4.18pre2aa2 VM (except 
> >perhaps the bdflush wakeup that seems to be a little too late and that
> >deals to lower numbers with slow write load etc.., fixable with bdflush
> >tuning). 
>
> I don't know if this is a reference to the issue I reported under the
> "Writeout in recent kernels..." thread or not. If not, my apologies for
> clogging up this new "discussion".
>
> As reported[0] in the above-mentioned thread, the bdflush tuning parameters
> you suggested made no difference in my test case other than slightly
> adjusting the temporal relationship between writeout and file transfer. -aa
> still performs slightly worse than both 2.4.17 stock and -rmap. 2.4.13-ac7 
> currently beats all competitors.

Put Andrew's read-latency.patch on -aa (10_vm-22) and see what you get out of 
it. It should fly...

-Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
