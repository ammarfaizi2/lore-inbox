Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWBFTjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWBFTjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWBFTjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:39:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23749 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932321AbWBFTji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:39:38 -0500
Date: Mon, 6 Feb 2006 20:39:37 +0100
From: Martin Mares <mj@ucw.cz>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       David Chow <davidchow@shaolinmicro.com>
Subject: Re: Linux drivers management
Message-ID: <mj+md-20060206.193433.6964.atrey@ucw.cz>
References: <1139250712.20009.20.camel@rousalka.dyndns.org> <200602061002.27477.joshua.kugler@uaf.edu> <200602062217.19697.yarick@it-territory.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602062217.19697.yarick@it-territory.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> And then think, why do you need to _build_ drivers in the first place.
> Wouldn't it be better to have one vmware.ko which insmod's with all
> 2.6 versions , from 2.6.0 to 2.6.16-rc2 , and throw "upgrade pain"
> away completely ? 

Well, you want the vmware.ko to contain machine code for at least 17
different architecture the kernel runs on? ;-)

> If kernel has stable ABI, basic/default driver is included on
> installation CD, and all you need to do 
[...]

... and I'm screwed if I happen to use a 2 years old network card with
written for a 2.4.x kernel, while I am running on 2.6.x.

> is to launch ./install-linux.sh from CD in your shell or click OK and
> enter your root password in GUI box. Newer/better driver - just go to
> device manufacturer's website, download installation package and
> install this driver. Without rebuilding. 

While now, I don't need to install or rebuild anything, just use the
stock kernel which already contains the drivers :)

> And what to do if you've bought new hardware, installed it and _voila_
> - NO IN-TREE DRIVER exists ?

The same like what I do if I buy new hardware and no Linux driver exist
-- call myself an uninformed ignoramus, because that's who I am.

> Please, don't force your preferences over others'

Doesn't this sentence apply to you as well? ;-)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
It said, "Insert disk #3," but only two will fit!
