Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWANGB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWANGB6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWANGBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:01:54 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:35662 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751680AbWANGB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:01:29 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: Mouse stalls (again) with 2.6.15-mm2
Date: Sat, 14 Jan 2006 01:01:17 -0500
User-Agent: KMail/1.8.3
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <9a8748490601091237s57071e57mbd2c4172a0e4dd@mail.gmail.com> <200601130154.47813.dtor_core@ameritech.net> <43C7B4C8.8060405@tuxrocks.com>
In-Reply-To: <43C7B4C8.8060405@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601140101.19800.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 09:10, Frank Sorenson wrote:
> Dmitry Torokhov wrote:
> > Hi,
> >
> > Here is the latest version of psmouse resync patch, it should have all
> > the fixes and handle both Jesper's KVM and Frank's touchpad. I would
> > appreciate if you give it a spin.
> >
> > The patch is against Linus, not -mm; for -mm you will have to revert
> > original resync patch.
> >
> > Thanks!
> 
> For me, the mouse and tapping both continue to work, but it is impossible
> to turn on resync (resync_time immediately switches back to 0).  Since
> things seem to continue working for me, that's fine by me, but is this
> the intended behavior?
>

FYI:

There was a confusion over psmouse sysfs attributes (they require "echo -n"),
Frank later confirmed that the resync was working for him so I am planning
getting this into mainline.

-- 
Dmitry
