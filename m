Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbTIEWGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTIEWGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:06:46 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:32264 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262743AbTIEWGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:06:40 -0400
Subject: Re: 2.6.0-test4-mm6
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Malte =?ISO-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>
Cc: linux-kernel@vger.kernel.org, Jan Ischebeck <mail@jan-ischebeck.de>
In-Reply-To: <200309051620.07380.MalteSch@gmx.de>
References: <1062758896.2085.19.camel@JHome.uni-bonn.de>
	 <200309051620.07380.MalteSch@gmx.de>
Content-Type: text/plain; charset=
Message-Id: <1062799577.2669.0.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 06 Sep 2003 00:06:17 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-05 at 16:20, Malte Schröder wrote:
> I have the same X problem on mm6. I use a Radeon 8500, Debian/Sid.

Me too on RHL 9.0.93 Beta (Severn)

> 
> On Friday 05 September 2003 12:48, Jan Ischebeck wrote:
> > On Friday 05 September 2003 16:59, Andrew Morton wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2
> >.6.0-test4-mm6/
> >
> >
> > Hi Andrew,
> >
> > Some first impressions:
> >
> > 1. swsusp works great (Thinkpad R40 2722)
> >
> > 2. X11R6 won't start anymore, it fails with a strange
> > Fatal server error:
> > xf86OpenConsole: VT_GETMODE failed
> > I can't find a reason for that in the changelog.
> >
> > 3. The oss mixer emulation doesn't load correctly, I get the following
> > messages in the syslog, f.e. after a "modprobe snd-mixer-oss":
> >
> > snd: Unknown parameter `device_mode'
> > snd_mixer_oss: Unknown symbol snd_info_register
> > snd_mixer_oss: Unknown symbol snd_info_free_entry
> > snd_mixer_oss: Unknown symbol snd_info_get_str
> > snd_mixer_oss: Unknown symbol snd_unregister_oss_device
> > snd_mixer_oss: Unknown symbol snd_ctl_find_id
> > snd_mixer_oss: Unknown symbol snd_register_oss_device
> > snd_mixer_oss: Unknown symbol snd_card_file_add
> > snd_mixer_oss: Unknown symbol snd_mixer_oss_notify_callback
> > snd_mixer_oss: Unknown symbol snd_iprintf
> > snd_mixer_oss: Unknown symbol snd_kcalloc
> > snd_mixer_oss: Unknown symbol snd_cards
> > snd_mixer_oss: Unknown symbol snd_ctl_notify
> > snd_mixer_oss: Unknown symbol snd_oss_info_register
> > snd_mixer_oss: Unknown symbol snd_kmalloc_strdup
> > snd_mixer_oss: Unknown symbol snd_info_create_card_entry
> > snd_mixer_oss: Unknown symbol snd_card_file_remove
> > snd_mixer_oss: Unknown symbol snd_info_unregister
> > snd_mixer_oss: Unknown symbol snd_info_get_line
> >
> > Could be connected with
> >
> > > +sound-remove-duplicate-includes.patch
> > > +kernel-remove-duplicate-includes.patch
> > >
> > > janitorial work
> >
> > 4. Powerdown via ACPI still doesn't work (broken since -test2 or -test1)
> >
> > Thanks for the great work.
> >
> > Jan
> >
> > (Please CC me on reply)

