Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317670AbSGLFBA>; Fri, 12 Jul 2002 01:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317675AbSGLFBA>; Fri, 12 Jul 2002 01:01:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52235 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317670AbSGLFA7>; Fri, 12 Jul 2002 01:00:59 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IDE/ATAPI in 2.5
Date: 11 Jul 2002 22:03:33 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aglnv5$qkg$1@cesium.transmeta.com>
References: <agl7ov$p91$1@cesium.transmeta.com> <E17Son2-0001yp-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E17Son2-0001yp-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
> > and treat all ATAPI devices as what they really are -- SCSI over IDE.
> 
> They aren't.
> 
> o	Not all ide cdrom devices are ATAPI capable
> o	Many ide floppy devices can do ATAPI but get it horribly wrong
> o	ide-tape is -totally- weird and unrelated to st
> 

OK, non-ATAPI devices need not apply, obviously, but the argument
still applies for ATAPI devices...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
