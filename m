Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTDVNTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 09:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbTDVNTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 09:19:17 -0400
Received: from mail.ithnet.com ([217.64.64.8]:49415 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263131AbTDVNTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 09:19:16 -0400
Date: Tue, 22 Apr 2003 15:31:13 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: war <war@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 + SiS + Adaptec AHA-7850
Message-Id: <20030422153113.18ecc6fb.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.55.0304220927580.12913@p300>
References: <Pine.LNX.4.55.0304212236380.12135@p300>
	<20030422123852.63c5d763.skraw@ithnet.com>
	<Pine.LNX.4.55.0304220927580.12913@p300>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003 09:28:09 -0400 (EDT)
war <war@lucidpixels.com> wrote:

> will this patch be included for 2.4.21 or 22?

Very unlikely I guess, though I cannot comment on the reasons. At least I can
find no stability issues. But it looks very invasive...

But you should not have problems patching 2.4.20. It runs quite straight forward.
URL: http://acpi.sourceforge.net/download.html


> 
> 
> On Tue, 22 Apr 2003, Stephan von Krawczynski wrote:
> 
> > Can be you are running into some problems with irq-routing and SIS chipset.
> > Try acpi-patch from sf. It worked for me.
> >
> > Regards,
> > Stephan
> >
> >
> > On Mon, 21 Apr 2003 22:38:23 -0400 (EDT)
> > war <war@lucidpixels.com> wrote:
> >
> > > Does not work...
> > > Boots up, probes each ID, fails, takes 15-20 sec per timeout for each ID,
> > > then actually does boot after (15-20sec)*7ID for that board.
> > >
> > > I used same exact (SCSI-CONFIG) for VIA board, worked fine, guess there
> > > are problems with IRQs or something?
> > >
> > > I'd send log/more information but don't feel like writing 10 pages of
> > > text down to send to lkml.
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
