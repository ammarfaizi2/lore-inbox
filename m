Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945913AbWBRBCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945913AbWBRBCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945929AbWBRBCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:02:16 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:59307
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1945913AbWBRBB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:01:27 -0500
Date: Fri, 17 Feb 2006 17:00:54 -0800
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
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
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060218010054.GA15980@kroah.com>
References: <1139934883.14115.4.camel@mulgrave.il.steeleye.com> <1140054960.3037.5.camel@mulgrave.il.steeleye.com> <20060216171200.GD29443@flint.arm.linux.org.uk> <1140112653.3178.9.camel@mulgrave.il.steeleye.com> <20060216180939.GF29443@flint.arm.linux.org.uk> <1140113671.3178.16.camel@mulgrave.il.steeleye.com> <20060216181803.GG29443@flint.arm.linux.org.uk> <1140116969.3178.24.camel@mulgrave.il.steeleye.com> <20060216200138.GA4203@suse.de> <1140223363.3231.9.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140223363.3231.9.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:42:43PM -0800, James Bottomley wrote:
> On Thu, 2006-02-16 at 21:01 +0100, Jens Axboe wrote:
> > That's what I suggested in the first place as well. I still think it's a
> > good idea, fwiw :)
> 
> OK smarty pants ... some of us are a bit slower on the uptake.  How
> about this then.  It won't solve the target problem, but it will solve
> the device put.
> 
> James
> 
> [PATCH] add execute_in_process_context() API

I like it, nice job.

Acked-by: Greg Kroah-Hartma <gregkh@suse.de>

thanks,

greg k-h
