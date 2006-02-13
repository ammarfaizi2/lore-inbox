Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWBMNJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWBMNJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWBMNJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:09:11 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55773 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751266AbWBMNJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:09:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Linux 2.6.16-rc3
Date: Mon, 13 Feb 2006 14:09:51 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>,
       "Ben Castricum" <lk@bencastricum.nl>, sanjoy@mrao.cam.ac.uk,
       Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit =?iso-8859-1?q?Bruchh=E4user?= <gbruchhaeuser@gmx.de>,
       Nicolas.Mailhot@laposte.net, Jaroslav Kysela <perex@suse.cz>,
       Patrizio Bassi <patrizio.bassi@gmail.com>,
       =?iso-8859-1?q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, "P. Christeas" <p_christ@hol.gr>,
       ghrt <ghrt@dial.kappa.ro>, jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org> <s5hk6bz4gca.wl%tiwai@suse.de>
In-Reply-To: <s5hk6bz4gca.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131409.54300.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 13:02, Takashi Iwai wrote:
> At Sun, 12 Feb 2006 19:05:20 -0800,
> Andrew Morton wrote:
> > 
> > - Patrizio Bassi <patrizio.bassi@gmail.com> has an alsa suspend
> >   regression ("alsa suspend/resume continues to fail for ens1370")
> 
> It's not a "regression".  PM didn't work with ens1370 at all in the
> eralier version.
> 
> About the problem there, I have no idea now what's wrong.  The
> suspend-to-disk works fine if the driver is built as module but not as
> built-in kernel.

That may be related to the fact that modular drivers are not present in
memory during resume (just a thought).

Greetings,
Rafael
