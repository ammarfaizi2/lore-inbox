Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTL2Upz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTL2Upy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:45:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:15578 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263792AbTL2Upw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:45:52 -0500
X-Authenticated: #552865
Date: Mon, 29 Dec 2003 21:52:52 +0100
From: Florian Schuele <schuele@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is it safe to ignore UDMA BadCRC errors?
Message-ID: <20031229205252.GB8418@spacken.de>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us> <20031229195235.GC26821@bounceswoosh.org> <20031229202432.GA8418@spacken.de> <20031229203448.GD27234@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229203448.GD27234@bounceswoosh.org>
X-PGP-KeyID: 0xBBCE086E
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.12.03 13:34 -0700, Eric D. Mudama wrote:

> On Mon, Dec 29 at 21:24, Florian Schuele wrote:
> >i wrote a mail to this list a few days ago.
> >i have the same error messages as the above.
> >but _only_ with kernel 2.6.0, _not_ with 2.4.20 ...
> >thats strange. isnt it?
> >after i little traffic on the hd`s the system freezes.
> 
> Your error message wasn't the same.

ups, sorry... i was too fast with my post...

> 
> You reported status 0x51 with error code 0x04.  That is the generic
> catch-all error message, which usually refers to aborted commands.
> Unfortunately, it's tough to know what command the system was
> attempting to issue when your drive aborted the command.  There may be
> some IDE debugging code you can enable to attempt to find out, but I
> don't know exactly how to do that, a linux IDE person will need to
> speak up... i'm just a generic IDE person.

ah, ok perhaps i`ll find a way to debug or someone else who can help.

> 
> The previous poster reported 0x51 with error code 0x80, that is
> specifically UDMA CRC errors, and I diagnosed it as such.
> 

-- 

florian schuele
