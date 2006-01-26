Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWAZTWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWAZTWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWAZTWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:22:21 -0500
Received: from styx.suse.cz ([82.119.242.94]:20878 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964844AbWAZTWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:22:20 -0500
Date: Thu, 26 Jan 2006 20:22:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126192243.GB10332@suse.cz>
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <20060126175506.GA32972@dspnet.fr.eu.org> <20060126181034.GA9694@suse.cz> <20060126182818.GA44822@dspnet.fr.eu.org> <Pine.LNX.4.61.0601261938180.14581@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601261938180.14581@yvahk01.tjqt.qr>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 07:38:37PM +0100, Jan Engelhardt wrote:
> >> Udev interfaces that and can be set up so that it assigns
> >> /dev/cdrecorder0, 1, ... to evey recorder in the system, implementing
> >> the userspace interface.
> >
> >Problem is, udev doesn't.  Or at least it varies from distribution to
> >distribution.  For instance recent gentoo creates /dev/cdrom*,
> >/dev/cdrw*, /dev/dvd*, /dev/dvdrw*.  Fedora core 3 creates
> >/dev/cdrom*, /dev/cdwriter*, /dev/dvd*, /dev/dvdwriter*.  I guess from
> >your email that SuSE does /dev/cdrecorder*.  And I'm not able to
> >guess what fedora core 5, mandrake, debian, slackware and infinite
> >number of derivatives do.
> 
> Plus you have to think about systems not using udev at all.
> Cheers, chaos preprogrammed.
 
Nope. Just let the user specify it. Either the user is experienced
enough to know what is the name of the CD recorder on his distro, or
he'll use precompiled distribution packages which will have the correct
default.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
