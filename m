Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbUBJHHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUBJHHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:07:38 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:640 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265669AbUBJHHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:07:37 -0500
Date: Tue, 10 Feb 2004 08:07:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040210070735.GA257@ucw.cz>
References: <200402041820.39742.wnelsonjr@comcast.net> <200402060006.32732.wnelsonjr@comcast.net> <20040207004700.0dd5e626.mikeserv@bmts.com> <200402070911.42569.murilo_pontes@yahoo.com.br> <20040209004812.GA18512@ucw.cz> <20040210025627.GA2117@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210025627.GA2117@yggdrasil.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 08:56:27PM -0600, Greg Norris wrote:
> On Mon, Feb 09, 2004 at 01:48:12AM +0100, Vojtech Pavlik wrote:
> > And here is a fix. Damn stupid mistake I made.
> 
> This appears to squash my problem as well (the "usb mouse/keyboard
> problems under 2.6.2" thread).  Thanx!!!

USB?? This was for PS/2 mice. If it fixed your USB mouse problem, you
were using PS/2 drivers with your USB mouse, which is wrong (although it
can work). You need to use USB drivers.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
