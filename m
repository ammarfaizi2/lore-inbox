Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318690AbSIKKcB>; Wed, 11 Sep 2002 06:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318691AbSIKKcB>; Wed, 11 Sep 2002 06:32:01 -0400
Received: from angband.namesys.com ([212.16.7.85]:1920 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318690AbSIKKcA>; Wed, 11 Sep 2002 06:32:00 -0400
Date: Wed, 11 Sep 2002 14:36:44 +0400
From: Oleg Drokin <green@namesys.com>
To: Andi Kleen <ak@muc.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre6
Message-ID: <20020911143644.A841@namesys.com>
References: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva> <20020911140047.A924@namesys.com> <20020911121438.20537@colin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020911121438.20537@colin.muc.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 12:14:38PM +0200, Andi Kleen wrote:

> > AGP stuff still does not work for me. (It broke somewhere around 2.4.20-pre4
> > and I reported it at that time, but nobody was interested in that somehow)
> Does the kernel print a message like "Advanced speculative caching feature present" 
> or not present at boot up? 

Nothing even remotely similar to that.
Also I greeped the source tree and have found nothing similar to that in source,
too.

> If yes does it go away when you boot with unsafe-gart-alias  ? 

There seems to be no such option, too
green@angband:~/bk_work/reiser3-linux-2.4> grep -r gart-alias *
green@angband:~/bk_work/reiser3-linux-2.4>

> What other command line options do you use? Perhaps mem=nopentium? If yes
> does it help when you boot without that and with unsafe-gart-alias specified.

Yes, if I remove mem=nopentium , it boots ok.

Bye,
    Oleg
