Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVGSCwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVGSCwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 22:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVGSCwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 22:52:12 -0400
Received: from atpro.com ([12.161.0.3]:32774 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261919AbVGSCwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 22:52:10 -0400
Date: Mon, 18 Jul 2005 22:51:47 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Richard Gooch <rg+lkml0@safe-mbox.com>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050719025146.GM3550@mail>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Richard Gooch <rg+lkml0@safe-mbox.com>, linux-kernel@vger.kernel.org
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <17115.55954.942676.450479@mailix.sanjose.privnets> <Pine.LNX.4.61.0507182202400.16975@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507182202400.16975@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/05 10:12:29PM +0200, Jan Engelhardt wrote:
> 
> Something's wondering me, though:
> FreeBSD "just" (5.0) introduced devfs, so either they are behind The Facts 
> (see udev FAQ), or devfs (anylinux/anybsd) is not so bad after all.

There's not much to wonder about here, the basic idea of devfs is a good
one which is why udev was written. The problems expressed on lkml about
devfs were with that specifically implementation, if a better
implementation had been merged originally udev might have never been
created. I really doubt FreeBSD took the Linux devfs code and integrated it
with their kernel, so the fact that FreeBSD is using a devfs now simply
means they like the idea of a dynamic /dev as well.

> 
> 
> 
> Jan Engelhardt

Jim.
