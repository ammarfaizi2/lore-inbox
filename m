Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292293AbSB0Jru>; Wed, 27 Feb 2002 04:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292295AbSB0Jrl>; Wed, 27 Feb 2002 04:47:41 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:14096 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292293AbSB0Jri>; Wed, 27 Feb 2002 04:47:38 -0500
Date: Wed, 27 Feb 2002 10:47:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Simon Turvey <turveysp@ntlworld.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE error on 2.4.17
Message-ID: <20020227104735.A29316@ucw.cz>
In-Reply-To: <E16fmJt-0001Xi-00@the-village.bc.nu> <006e01c1bef6$6dd78e40$030ba8c0@mistral>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <006e01c1bef6$6dd78e40$030ba8c0@mistral>; from turveysp@ntlworld.com on Tue, Feb 26, 2002 at 06:50:15PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 06:50:15PM -0000, Simon Turvey wrote:
> The drive's less than a year old :-(
> 
> Should I try disabling some of the UDMA stuff?

That won't help, this indeed is a media error. The drive is heading to
hell. You have about another six months of life before it goes belly up
completely.

Any chance it's one of those fast IBM 30 or 45 gig drives? They seem to
be dying pretty fast ...

> 
> ----- Original Message ----- 
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> To: "Simon Turvey" <turveysp@ntlworld.com>
> Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
> Sent: Tuesday, February 26, 2002 6:27 PM
> Subject: Re: IDE error on 2.4.17
> 
> 
> > > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > > hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=250746,
> > > sector=250680
> > > end_request: I/O error, dev 03:01 (hda), sector 250680
> > 
> > Uncorrectable error is a message from your disk, along the lines of "Hey
> > pal I wonder if the warranty has expired yet"
> > 
> > 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
