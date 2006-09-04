Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWIDWDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWIDWDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWIDWDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:03:36 -0400
Received: from smtp.flash.net.br ([201.46.240.48]:55244 "EHLO
	smtp.gru.flash.tv.br") by vger.kernel.org with ESMTP
	id S1751485AbWIDWDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:03:35 -0400
Date: Mon, 4 Sep 2006 18:32:24 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
       linux-netdev@vger.kernel.org, John Heffner <jheffner@psc.edu>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Problems with ipv4 part of Kernels post-2.6.16
Message-ID: <20060904213223.GA10823@ime.usp.br>
References: <20060903201335.GA3703@ime.usp.br> <20060903183403.GB604@1wt.eu> <5a4c581d0609031507w54a397c4g2876b47b2fbbd45c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a4c581d0609031507w54a397c4g2876b47b2fbbd45c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Willy, Alessandro and others,

On Sep 04 2006, Alessandro Suardi wrote:
> On 9/3/06, Willy Tarreau <w@1wt.eu> wrote:
> >Hi Rogério,
> >
> >On Sun, Sep 03, 2006 at 05:13:35PM -0300, Rogério Brito wrote:
> >> I can't access (from where I am) the site www.everymac.com, while I
> >> can access other sites.
> >
> >I believe I read on LKML last month that there's a problem on this
> >site with window scaling. There's a patch floating around to allow
> >per destination window clamping. I believe that you can workaround
> >the problem by disabling TCP window scaling :
> >
> >   echo 0 >/proc/sys/net/ipv4/tcp_window_scaling

I still have not had the opportunity of disabling TCP window scaling,
since I'm running a quite intensive process right now under a kernel
that doesn't exhibit the problem.

> The above does help while hitting certain websites from behind my
> corporate proxy (while others are okay); same websites can be accessed
> without any issue from my home ISP connection.

Well, it's "nice" to see that I am not the only one hitting this
problem.  :-(

> I logged an internal ticket for this, will check whether there's been
> any update as of recently; both happens with recent 2.6.18-rc and with
> FC5-latest kernel.

One thing that I might test (when I have some time) is to just reverse
the patch and see if the problem persists, but, of course, the net
developers would know much better what should be done.


Thanks for the answers, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
