Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUFQTWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUFQTWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUFQTU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:20:28 -0400
Received: from witte.sonytel.be ([80.88.33.193]:37095 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261925AbUFQTQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:16:15 -0400
Date: Thu, 17 Jun 2004 21:15:58 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Finn Thain <ft01@webmastery.com.au>, Andreas Schwab <schwab@suse.de>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: make checkstack on m68k
In-Reply-To: <20040617182658.GB29029@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.58.0406172115050.1495@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
 <je3c4uqum0.fsf@sykes.suse.de> <Pine.LNX.4.58.0406180048180.13963@bonkers.disegno.com.au>
 <20040617182658.GB29029@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, [iso-8859-1] Jörn Engel wrote:
> On Fri, 18 June 2004 01:17:31 +1000, Finn Thain wrote:
> > On Thu, 17 Jun 2004, Andreas Schwab wrote:
> > >
> > >   $re = qr/.*(?:linkw %fp,|addw )#-([0-9]{1,4})(?:,%sp)?$/o;
> >
> > I think that should be addaw, not addw. And it may be necessary to remove
> > the $ anchor at the end.
>
> Changed, updated patch below.  Thanks.
>
> Can anyone test?

Doesn't work ;-(

I also tried with

    $re = qr/.*(?:linkw %fp,|addaw )#-([0-9]{1,4})(?:,%sp)?$/o;

but still didn't work ;-(

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
