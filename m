Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313751AbSDHVJW>; Mon, 8 Apr 2002 17:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313753AbSDHVJV>; Mon, 8 Apr 2002 17:09:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58631 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313751AbSDHVJU>; Mon, 8 Apr 2002 17:09:20 -0400
Date: Mon, 8 Apr 2002 23:09:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, Pavel Machek <pavel@suse.cz>,
        Andrew Morton <akpm@zip.com.au>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, nahshon@actcom.co.il,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020408210922.GD31172@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408095717.GB27999@atrey.karlin.mff.cuni.cz> <20020408174333.A28116@kushida.apsleyroad.org> <20020408124803.A14935@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Well, noflushd already seems to work pretty well ;-). But I see kernel
> > > support may be required for SCSI.
> > 
> > I've had no luck at all with noflushd on my Toshiba Satellite 4070CDT.
> > It would spin down every few minutes, and then spin up _immediately_,
> > every time.  I have no idea why.
> 
> Were you using the console?  Any activity on ttys causes device inode 
> atime/mtime updates which trigger disk spin ups.  The easiest way to 
> work around this is to run X while using devpts for the ptys.

Noflushd does not spin up disks for write activity.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
