Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbTCWJBI>; Sun, 23 Mar 2003 04:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262983AbTCWJBI>; Sun, 23 Mar 2003 04:01:08 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:33159 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262982AbTCWJBI>; Sun, 23 Mar 2003 04:01:08 -0500
Date: Sun, 23 Mar 2003 10:11:47 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
Message-ID: <20030323091147.GB1113@brodo.de>
References: <20030322162502.GA870@brodo.de> <Pine.SOL.4.30.0303221730110.15619-200000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0303221730110.15619-200000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 11:03:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> On Sat, 22 Mar 2003, Dominik Brodowski wrote:
> > On Sat, Mar 22, 2003 at 04:35:05PM +0000, Alan Cox wrote:
> > >
> > > I've seen 3 or 4 reports of this, none of them duplicatable with the same IDE
> > > code on 2.4 so far. Which is odd but I don't yet understand what is going on.
> > /me neither, unfortunately :-(
> 
> 
> Alan, I can trigger the same dma_intr bug under 2.4.21-pre5-ac3 but not
> 2.4.20-ac2 (VIA vt8235 + WD800JB so it is not controller/disk related).
> 
> Dominik could you try attached patch with vanilla 2.5.65?
> It reverts previous logic of handling masked_irq argument of ide_do_request().

Seems to work fine over here...

> BTW 2.5.64-ac4 deadlocks for me the same way Dominik has described.

plain 2.5.65 does not, but 2.5.65-bk-current does.

	Dominik
