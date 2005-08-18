Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVHRVif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVHRVif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVHRVie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:38:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10933 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932473AbVHRVie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:38:34 -0400
Date: Thu, 18 Aug 2005 23:38:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adam Goode <adam@evdebs.org>
Cc: Jens Axboe <axboe@suse.de>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
Subject: Re: HDAPS, Need to park the head for real
Message-ID: <20050818213823.GA4275@elf.ucw.cz>
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de> <20050818204904.GE516@openzaurus.ucw.cz> <1124399756.28353.0.camel@lynx.auton.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124399756.28353.0.camel@lynx.auton.cs.cmu.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please make it "echo 1 > frozen", then userspace can do "echo 0 > frozen"
> > after five seconds.
> 
> What if the code to do "echo 0 > frozen" is swapped out to disk? ;)

Emergency head parker needs to be pagelocked for other reasons. You do
not want to page it from disk while your notebook is in free fall.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
