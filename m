Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUHFOtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUHFOtK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUHFOtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:49:10 -0400
Received: from users.linvision.com ([62.58.92.114]:19605 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S265996AbUHFOsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:48:46 -0400
Date: Fri, 6 Aug 2004 16:48:45 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040806144845.GD21660@harddisk-recovery.nl>
References: <200408061420.i76EKUHp006230@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061420.i76EKUHp006230@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 04:20:30PM +0200, Joerg Schilling wrote:
> You know what a cut/paste error is?

I know, but a cut error with 15 lines apart is a bit odd. You shouldn't
use the "unreadable" font for xterms, that makes the "cut" action a lot
easier :)

But then again, like I explained before: even if you would have pasted
SG_MAX_SENSE in your message, it would still not make sense, cause that
is being used in the old and deprecated sg_header interface (which you
should not and apparently do not use in cdrecord).

> BTW: this could be avoided if Linux would supply correct termcap/terminfo
> entries for xterm so the screen would not go white on black on
> every odd try :-(

Making up this kind of excuses doesn't really improve your credibility.
Just admit and fix the bug in cdrecord, and work with Jens to fix the
remaining bugs in the kernel. Everybody makes mistakes, even people
with over 20 years of experience.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
