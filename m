Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWCADJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWCADJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWCADJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:09:59 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:23910 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964847AbWCADJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:09:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] make UNIX a bool
Date: Tue, 28 Feb 2006 22:09:52 -0500
User-Agent: KMail/1.9.1
Cc: "James C. Georgas" <jgeorgas@rogers.com>, linux-kernel@vger.kernel.org
References: <20060225160150.GX3674@stusta.de> <1141078686.28136.20.camel@Rainsong.home> <20060227222926.GX3674@stusta.de>
In-Reply-To: <20060227222926.GX3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602282209.52638.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 17:29, Adrian Bunk wrote:
> On Mon, Feb 27, 2006 at 05:18:06PM -0500, James C. Georgas wrote:
> > On Sat, 2006-25-02 at 17:01 +0100, Adrian Bunk wrote:
> > > CONFIG_UNIX=m doesn't make much sense.
> > 
> > I've been building it as a module forever. I often load kernels from
> > floppy disk, and building CONFIG_UNIX as a module often makes the
> > difference between the kernel fitting or not fitting on the disk. Could
> > we please keep this functionality?
> 
> If size is important for you, you should consider completely disabling 
> module support in your kernels:
> 
> In my testing, disabling module support brings you a space gain in the 
> range of 10%.
>

This only matters when you tight on memory - in the scenario above memory
may not be a great concern but kernel image size is because modules could
go on other medium.

-- 
Dmitry
