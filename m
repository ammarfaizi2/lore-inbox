Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281862AbRKSA5V>; Sun, 18 Nov 2001 19:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281867AbRKSA5L>; Sun, 18 Nov 2001 19:57:11 -0500
Received: from smtp01.iprimus.net.au ([203.134.64.99]:18442 "EHLO
	smtp01.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S281862AbRKSA4v>; Sun, 18 Nov 2001 19:56:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Paul <krushka@iprimus.com.au>
Reply-To: krushka@iprimus.com.au
To: linux-kernel@vger.kernel.org
Subject: Re: Compact Flash and IDE interface
Date: Mon, 19 Nov 2001 11:02:50 +1000
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0111181039410.11341-100000@twin.uoregon.edu>
In-Reply-To: <Pine.LNX.4.33.0111181039410.11341-100000@twin.uoregon.edu>
MIME-Version: 1.0
Message-Id: <01111911025000.08520@paul.home.com.au>
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 19 Nov 2001 00:56:38.0337 (UTC) FILETIME=[0B325310:01C17095]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After doubting my memory I jumped over to 
http://www.sandisk.com/oem/cf-spec.htm to check out the specs again.  Sure 
enough they state:

Data Transfer Rate to/from Flash 20.0 MB/sec burst 
Data Transfer Rate to/from Host 16.0 MB/sec burst

I have designed my own compact flash to IDE converter from schematics 
supplied by sandisk.  Perhaps the continuous data transfer rate is only 
around 2MB/sec...They fail to mention that so it's probably the case :)

Thanks for your replies, Paul.

On Mon, 19 Nov 2001 04:44, Joel Jaeggli wrote:
> 2MB a second is about right... Flash is slow... I get about that on an
> older 64MB simple technologies flash card... maybe their doc says 16Mb/s
> which would be quite accurate...
>
> On Sun, 18 Nov 2001, Paul wrote:
> > Hi
> >
> > I hope I'm sending this to the right list, sorry if it's not :)
> >
> > With compact flash cards connected via IDE what is the "normal" expected
> > transfer rates?  I have a Sandisk (32 and 128MB) and I only get around
> > 2MB/sec (read test using hdparm) when all the docs from sandisk suggest
> > around 16MB/sec.  They haven't returned my emails so I suspect their
> > specs are a little misleading...they quote around 16MB/sec read transfer
> > rates.
> >
> > What sort of read rates should I be expecting?
> >
> > Thanks
> >
> > Paul
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
