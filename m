Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUEAQRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUEAQRs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 12:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUEAQRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 12:17:48 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:57473 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262381AbUEAP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 11:59:41 -0400
Date: Sun, 2 May 2004 01:58:08 +1000
From: CaT <cat@zip.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
Message-ID: <20040501155808.GB1404@zip.com.au>
References: <20040429234258.GA6145@zip.com.au> <20040501030828.GE2109@zip.com.au> <20040430222157.17f5db82.akpm@osdl.org> <200405011715.53580.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405011715.53580.bzolnier@elka.pw.edu.pl>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 05:15:53PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 01 of May 2004 07:21, Andrew Morton wrote:
> > CaT <cat@zip.com.au> wrote:
> > >  +/*
> > >  + * Halt Disconnect and Stop Grant Disconnect (bit 4 at offset 0x6F)
> > >  + * must be disabled when APIC is used (or lockups will happen).
> > >  + */
> 
> LOL, CaT this is my old patch. :)

Heh. What goes around, comes around it seems. :)

> > I had this in -mm for a while.  Ended up dropping it because it made some
> > people's CPUs run warmer and because it "wasn't the right fix".
> >
> > Does anyone know what the right fix is?  If not, it seems that a warm CPU
> > is better than a non-functional box.  Maybe enable it via a boot option?
> 
> Ross' recent patch is a good workaround.

Where can I find this patch? I'll give it a go.

-- 
    Red herrings strewn hither and yon.
