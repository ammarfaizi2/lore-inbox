Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWBSOb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWBSOb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 09:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWBSOb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 09:31:26 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:37019 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932569AbWBSObZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 09:31:25 -0500
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Sergey Vlasov <vsu@altlinux.ru>
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
In-Reply-To: <20060218100344.GA8532@procyon.home>
References: <1139934883.14115.4.camel@mulgrave.il.steeleye.com>
	 <1140054960.3037.5.camel@mulgrave.il.steeleye.com>
	 <20060216171200.GD29443@flint.arm.linux.org.uk>
	 <1140112653.3178.9.camel@mulgrave.il.steeleye.com>
	 <20060216180939.GF29443@flint.arm.linux.org.uk>
	 <1140113671.3178.16.camel@mulgrave.il.steeleye.com>
	 <20060216181803.GG29443@flint.arm.linux.org.uk>
	 <1140116969.3178.24.camel@mulgrave.il.steeleye.com>
	 <20060216200138.GA4203@suse.de>
	 <1140223363.3231.9.camel@mulgrave.il.steeleye.com>
	 <20060218100344.GA8532@procyon.home>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 08:30:58 -0600
Message-Id: <1140359458.3103.11.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-18 at 13:03 +0300, Sergey Vlasov wrote:
> After removing kfree(), which was here in the initial implementation,
> this function became a thunk which does nothing useful - we can just
> stick fn and data directly into work_struct.

Yes, thanks ... although I think there's still value to wrappering
work_struct (a bit like kref wrappers atomic_t).

James


