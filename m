Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264877AbTL1FGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 00:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbTL1FGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 00:06:44 -0500
Received: from [64.65.177.98] ([64.65.177.98]:23263 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S264877AbTL1FGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 00:06:43 -0500
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net, azarah@nosferatu.za.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       Stan Bubrouski <stan@ccs.neu.edu>, swidmer@caowash.org
In-Reply-To: <8240000.1072511437@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>
	 <2060000.107248  <8240000.1072511437@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1072587986.32719.10.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 21:06:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I leave xmms playing (in random shuffle mode) every 2 minutes or so,
> I'll get some wierd effect for a few seconds, either static, or the track
> will mysteriously speed up or slow down. Then all is back to normal for
> another couple of minutes.

We had this problem with an Intel 8x0 sound chipset, turned out to be
that the chipset requires a fixed bit rate.  I can't remember what we
did to fix it, but I will ask my friend who has the system.


js


-- 
VB programmers ask why no one takes them seriously, 
it's somewhat akin to a McDonalds manager asking employees 
why they don't take their 'career' seriously.

