Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWCUTz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWCUTz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWCUTz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:55:27 -0500
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:50855 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965100AbWCUTz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:55:26 -0500
Date: Tue, 21 Mar 2006 11:55:23 -0800 (PST)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
In-Reply-To: <442050C8.1020200@zytor.com>
Message-ID: <Pine.LNX.4.58.0603211154530.31582@shell3.speakeasy.net>
References: <1142890822.5007.18.camel@localhost.localdomain>
 <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com>
 <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr> <44203B86.5000003@zytor.com>
 <Pine.LNX.4.61.0603211854150.21376@yvahk01.tjqt.qr> <442040CB.2020201@zytor.com>
 <Pine.LNX.4.61.0603211911090.2314@yvahk01.tjqt.qr> <44204BD9.1090103@zytor.com>
 <Pine.LNX.4.61.0603212005250.6840@yvahk01.tjqt.qr> <442050C8.1020200@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, H. Peter Anvin wrote:

> Jan Engelhardt wrote:
> >>>>You're confusing characters which aren't legal *VFAT* names which those
> >>>>which
> >>>>aren't legal *FAT* (8.3) names.
> >>>
> >>>Could you please name an illegal FAT name being legal VFAT name?
> >>
> >>"Green Furry Submarine"
> >>
> >
> > Ah well. But aux.h is also forbidden under VFAT, is not it? Or no, because
> > it's "just" an 8.3 name?
> >
>
> It probably depends on how picky you want to be.  As far as I know, even
> NT will recognize a character device name without leaving \DEV\, even
> though \DEV\ has been the "official" device prefix since DOS 2.0.
>
> Probably it would be worth trying to create "aux.h" under XP and see
> what happens.  Unfortunately I don't have a 'doze system handy at the
> moment.

Fails silently.

> 	-hpa
>
> -

Vadim Lobanov
