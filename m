Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284139AbRLWTnA>; Sun, 23 Dec 2001 14:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284135AbRLWTmk>; Sun, 23 Dec 2001 14:42:40 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:272 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S284133AbRLWTmb>;
	Sun, 23 Dec 2001 14:42:31 -0500
Date: Sun, 23 Dec 2001 20:42:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
Message-ID: <20011223204227.A13661@suse.cz>
In-Reply-To: <20011222164602.A20623@Sophia.soo.com> <3C250835.9010806@wanadoo.fr> <20011223151147.F7438@suse.de> <20011223120825.A22239@Sophia.soo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011223120825.A22239@Sophia.soo.com>; from lnx-kern@Sophia.soo.com on Sun, Dec 23, 2001 at 12:08:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 12:08:25PM -0500, really mason_at_soo_dot_com wrote:
> Yikes, hope not.  But yeps, i'm using IDE drives,
> ATA100 master and ATA66 slave.  It's a VIA vt8233
> south bridge.  i also have the FSB overclocked so
> the PCI bus is running at 37mhz.  That's caused
> no trouble so far.

And you did tell the VIA ide driver to compensate for the 37MHz, did
you? ('idebus=37' kernel option)

> 
> b
> 
> On Sun, Dec 23, 2001 at 03:11:47PM +0100, Jens Axboe wrote:
> > This sounds like disk corruption, it may be that the -pre1 changes are
> > partially broken.
> > 
> > I'll go take a look. IDE?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
