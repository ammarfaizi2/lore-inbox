Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWALL7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWALL7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWALL7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:59:09 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:59269 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964905AbWALL7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:59:08 -0500
Date: Thu, 12 Jan 2006 12:58:58 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/10] NTP: Remove pps support
In-Reply-To: <43C4DB67.24764.AB21FFF@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0601121253060.11765@scrub.home>
References: <Pine.LNX.4.61.0512220019330.30882@scrub.home>
 <43C4DB67.24764.AB21FFF@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Jan 2006, Ulrich Windl wrote:

> accidentially ;-) I did merge my PPSkit-light into SuSE's 2.6.13 tree.

Maybe there is something more recent (I only know of the stuff at 
kernel.org), but that wasn't exactly merge material.

> Does a release candidate kernel have the nanosecond clock in now? I got that 
> impression recently.

Well, I did everything except to the user interface, so basically only 
STA_NANO is missing, but that requires userspace updates as well, so I 
haven't done it yet.

> BTW: Leaving the old crap in the kernel would help me to merge my stuff (Looking 
> for "anchors" in the sources).

It's not that much to add back and this way it can be done properly (i.e. 
with a config option).

bye, Roman
