Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWBMIKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWBMIKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWBMIKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:10:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51228 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751210AbWBMIKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:10:38 -0500
Date: Mon, 13 Feb 2006 09:11:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit =?iso-8859-1?Q?Bruchh=E4user?= <gbruchhaeuser@gmx.de>,
       Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, Patrizio Bassi <patrizio.bassi@gmail.com>,
       =?iso-8859-1?Q?Bj=F6rn?= Nilsson <bni.swe@gmail.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, "P. Christeas" <p_christ@hol.gr>,
       ghrt <ghrt@dial.kappa.ro>, jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060213081142.GA4203@suse.de>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212190520.244fcaec.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12 2006, Andrew Morton wrote:
> 
> We still have some serious bugs, several of which are in 2.6.15 as well:
> 
> - The scsi_cmd leak, which I don't think is fixed.

It is fixed in 2.6.16-rcX.

> - The some-x86_64-boxes-use-GFP_DMA-from-bio-layer bug, which causes
>   oom-killings.

Still pending.

-- 
Jens Axboe

