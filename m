Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWBSNwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWBSNwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 08:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWBSNwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 08:52:16 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:63130 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932442AbWBSNwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 08:52:15 -0500
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jens Axboe <axboe@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit Bruchh?user <gbruchhaeuser@gmx.de>, Nicolas.Mailhot@LaPoste.net,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Patrizio Bassi <patrizio.bassi@gmail.com>,
       Bj?rn Nilsson <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
       jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
In-Reply-To: <Pine.LNX.4.44L0.0602181515350.4115-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0602181515350.4115-100000@netrider.rowland.org>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 07:51:17 -0600
Message-Id: <1140357077.3103.0.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-18 at 15:16 -0500, Alan Stern wrote:
> The test should be in_atomic(), not in_interrupt().

There's a long prior discussion of why it has to be in_interrupt()

James


