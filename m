Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWI2Wrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWI2Wrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWI2Wrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:47:37 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:29632 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932123AbWI2Wrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:47:37 -0400
Date: Fri, 29 Sep 2006 15:43:16 -0700
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Message-ID: <20060929224316.GA10423@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com> <20060929202928.GA14000@tuxdriver.com> <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com> <20060929212748.GA10288@bougret.hpl.hp.com> <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 12:04:31AM +0200, Alessandro Suardi wrote:
> On 9/29/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
> >>
> >> [asuardi@sandman ~]$ rpm -q wireless-tools
> >> wireless-tools-28-0.pre13.5.1
> >
> >        That's too old, the cutoff is 27-pre15.
> 
> Are you sure ? For how I read it, 28-0.pre13.5.1 is more recent
> than 27-pre15, not older.

	Sorry, I'm mixing up my numbers.
	The cutoff for the ESSID fix is 28-pre15, so your version is
just a little bit older. I'm mixing up with the iwpoint cutoff which
was 27-pre25.

> So I guess there's an actual bug that doesn't depend on the
> wireless-tools. Or maybe it's wpa_supplicant that has to be
> upgraded ?

	I don't have the start of the thread, so I don't know the
exact failure mode. If you are using wpa_supplicant, it bypasses the
wireless tools so it would have to be updated.
	Note that I've been pestering Jouni about the fact that he had
to update wpa_supplicant for that since last May, when Jouni himself
asked me to change the ESSID API. Ironic, isn't it ?
	The epitest.fi site seems unfortunately down...

> >        On the other hand, FC6, which is in beta, contains already the
> >proper version of the tools. I have been monitoring the various distro
> >in the last few months before sending those WE-21 patches, and all
> >major distro have WT-28 in the pipeline.
> 
> Even if so, wireless-tools would be the only package I have to
> build out of the FC5 distribution to keep up with the latest -git
> snapshot of the Torvalds kernel... I'm not especially troubled
> with this anyway. Perhaps you could push the Fedora folks to
> be a bit more up-to-date with wireless-tools in their current
> main version ?

	The FC people are busy.

> Still listening on how to further research the issue... many thanks
> in the meantime, ciao,
> 
> --alessandro

	Jean
