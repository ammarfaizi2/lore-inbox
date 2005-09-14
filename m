Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVINA0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVINA0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 20:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVINA0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 20:26:45 -0400
Received: from sa3.bezeqint.net ([192.115.104.17]:54430 "EHLO sa3.bezeqint.net")
	by vger.kernel.org with ESMTP id S964939AbVINA0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 20:26:44 -0400
Date: Wed, 14 Sep 2005 03:42:43 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Dmitrij Bogush <dmitrij.bogush@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: snd-via82xx-modem do not work from 2.6.12 kernel version
Message-ID: <20050914004243.GA10774@tecr>
Mail-Followup-To: "Randy.Dunlap" <rdunlap@xenotime.net>,
	Dmitrij Bogush <dmitrij.bogush@gmail.com>,
	linux-kernel@vger.kernel.org
References: <2ac89c70050913145926583918@mail.gmail.com> <20050913235609.GB9531@tecr> <Pine.LNX.4.50.0509131643010.3527-100000@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0509131643010.3527-100000@shark.he.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:43 Tue 13 Sep     , Randy.Dunlap wrote:
> On Wed, 14 Sep 2005, Sasha Khapyorsky wrote:
> 
> > On 01:59 Wed 14 Sep     , Dmitrij Bogush wrote:
> > > I try to get MC97 modem working with 2.6.14-rc1 and get "NO DIAL
> > > TONE". I think that something wrong with driver source, becouse if
> > > replace snd-via82xx-modem.c with 2.6.11 version and recompile modules
> > > all works fine..
> >
> > Try with 2.6.13, this should be fixed.
> >
> > Sasha.
> 
> Sasha, his report was with 2.6.14-rc1 failing.

Oh, I thought about 2.6.12.

> Should it (still) be fixed in 2.6.14-rc1?

The driver itself is not changed from 2.6.13, but it was from 2.6.11 -
now 'hook-off' is controlled via ALSA mixer.

Dmitrij, I guess you are using slmodem, be sure that you are with recent
versions (http://linmodems.technion.ac.il).

Sasha.
