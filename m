Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTJTSBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 14:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbTJTSBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 14:01:06 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:52174 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S262707AbTJTSBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 14:01:03 -0400
From: David Lang <david.lang@digitalinsight.com>
To: John Bradford <john@grabjohn.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Rik van Riel <riel@redhat.com>, "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Nuno Silva'" <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
Date: Mon, 20 Oct 2003 10:48:38 -0700 (PDT)
Subject: RE: Blockbusting news, this is important (Re: Why are bad disk se
 ctors numbered strangely, and what happens to them?)
In-Reply-To: <200310201749.h9KHnQ0C000781@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.58.0310201046070.10996@dlang.diginsite.com>
References: <Pine.LNX.4.44.0310201153150.26888-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.53.0310201204100.13739@chaos> <200310201749.h9KHnQ0C000781@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rotating storage is hitting $1 per gig, memory is running ~$100/gig
(substantially more for the highest density memory)

making a small solid state drive is easy, cheap and definantly has some
uses, but making something that will replace stacks of 300G drives is
neither cheap or easy.

David Lang


On Mon, 20 Oct 2003, John Bradford wrote:

> Date: Mon, 20 Oct 2003 18:49:26 +0100
> From: John Bradford <john@grabjohn.com>
> To: Richard B. Johnson <root@chaos.analogic.com>,
>      Rik van Riel <riel@redhat.com>
> Cc: "Mudama, Eric" <eric_mudama@Maxtor.com>,
>      'Nuno Silva' <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
> Subject: RE: Blockbusting news,
>      this is important (Re: Why are bad disk se ctors numbered strangely,
>      and what happens to them?)
>
> > Battery-backed SRAM "drives" in the gigabyte sizes already exist.
> > Terabytes should not be too far off.
> >
> > Soon those "drives" will be as cheap as their mechanical emulations
> > and you won't need those metal boxes with the rotating mass anymore.
> > The batteries last about 10 years. Better than most mechanical
> > drives.
>
> You could make a solid state device really cheaply yourself - all you
> need is a simple circuit that will allow you to connect 512 Mb of
> EPROMs to the parallel port, and write a device driver to make them
> appear as a block device.  If you wan to boot from it, just find any
> old network card with a boot PROM socket, write a bootloader which
> could read a kernel image from the parallel port connected device,
> write that bootloader to a PROM, and put it on the network card.
>
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
