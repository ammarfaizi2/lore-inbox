Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRAEQ4F>; Fri, 5 Jan 2001 11:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRAEQzz>; Fri, 5 Jan 2001 11:55:55 -0500
Received: from barbados.bluemug.com ([63.195.182.101]:50960 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S129868AbRAEQzj>; Fri, 5 Jan 2001 11:55:39 -0500
Date: Fri, 5 Jan 2001 08:55:14 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Lang <david.lang@digitalinsight.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010105085514.A12902@bluemug.com>
Mail-Followup-To: miket, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Lang <david.lang@digitalinsight.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Daniel Phillips <phillips@innominate.de>,
	Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0101040954040.10387-100000@dlang.diginsite.com> <E14EEr4-000697-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14EEr4-000697-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 04, 2001 at 06:11:11PM +0000
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 06:11:11PM +0000, Alan Cox wrote:
> > in an enbedded device you can
> > 1. setup the power switch so it doesn't actually turn things off (it
> > issues the shutdown command instead)
> 
> Costs too much money

Many newer cell phones, even low spec ones, will have a software
power switch (usually with a hardware override after about 5 seconds
of continuous press).  There are many other concessions that need to
be made to power efficiency, like the ability to toggle power to even
very minor peripherals and chips (not only each CPU and DSP, but the bus
controllers and UARTs connecting things together).  These things sell
in the millions, so their designers can easily budget the custom logic.

miket

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
