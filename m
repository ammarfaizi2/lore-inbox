Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317964AbSGLBXS>; Thu, 11 Jul 2002 21:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317965AbSGLBXR>; Thu, 11 Jul 2002 21:23:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:51977
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317964AbSGLBXQ>; Thu, 11 Jul 2002 21:23:16 -0400
Date: Thu, 11 Jul 2002 18:23:05 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <E17Son2-0001yp-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10207111821080.20499-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Alan Cox wrote:

> > Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
> > and treat all ATAPI devices as what they really are -- SCSI over IDE.
> 
> They aren't.
> 
> o	Not all ide cdrom devices are ATAPI capable
> o	Many ide floppy devices can do ATAPI but get it horribly wrong
> o	ide-tape is -totally- weird and unrelated to st
> 
> Andre did the framework ready to move to a situation where you could open
> either the ide-scsi or the ide-cdrom name without module reloading mess.
> You'd need to ask our new 2.5 IDE maintainer to finish that work off.

It was deleted, LOL.

What you really need another NEW maintainer or any other replacement.

> For disk it gets much easier. Linus has already said he wants a single
> 'disk' device, which once we get 32bit dev_t will be nice. With that we
> can finally turn aacraid, megaraid and other 'fake scsi' devices back to
> raw block devices without breaking compatibility assumptions, and get more
> throughput.
> 
> Alan
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

