Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965330AbWGJXll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbWGJXll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965333AbWGJXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:41:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29139 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965330AbWGJXlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:41:40 -0400
Subject: Re: Automatic Kernel Bug Report
From: Lee Revell <rlrevell@joe-job.com>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       Pavel Machek <pavel@ucw.cz>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <e1e1d5f40607101505peb27581n729bcb14842d2956@mail.gmail.com>
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <20060709125805.GF13938@stusta.de>
	 <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
	 <20060709191107.GN13938@stusta.de>
	 <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
	 <200607092019.k69KJt66005527@turing-police.cc.vt.edu>
	 <e1e1d5f40607091327y3db1cbdco89ebdb04cda60ce0@mail.gmail.com>
	 <20060710081131.GA2251@elf.ucw.cz>
	 <e1e1d5f40607101040u3baf0da7r43d5538700b02e2@mail.gmail.com>
	 <200607101759.k6AHxbda012403@turing-police.cc.vt.edu>
	 <e1e1d5f40607101505peb27581n729bcb14842d2956@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 19:41:28 -0400
Message-Id: <1152574888.19047.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 18:05 -0400, Daniel Bonekeeper wrote:
> That's a good example. Another example: a little while ago
> (http://lkml.org/lkml/2006/7/1/70) Daniel Drake from Gentoo was
> reporting a problem where page_mapcount(page) was getting negative. As
> it turned out, it was related with a nVidia proprietary driver that
> the machine was running. With the system, we just needed to search for
> "Eeek! page_mapcount(page) went negative! (-1)" on kernels 2.6.16.19
> (maybe too generic), and he would see that lots of people reporting
> that has, between other things, nVidia drivers running. It's already a
> clue on where to start looking for. The same applies for lots of other
> stuff. 

That sounds backwards to me - any kernel bug reporting system should
immediately discard bug reports with the nvidia driver loaded, as such a
kernel is not debuggable.

Lee

