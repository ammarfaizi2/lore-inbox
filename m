Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWDRVI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWDRVI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 17:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWDRVIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 17:08:55 -0400
Received: from bay105-f2.bay105.hotmail.com ([65.54.224.12]:35605 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750837AbWDRVIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 17:08:55 -0400
Message-ID: <BAY105-F2468C2D68B76D90015BF4A3C40@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
In-Reply-To: <1145369135.18736.49.camel@localhost.localdomain>
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: [RFC] Get DMA to work for CD/DVD with pdc202xx_old
Date: Tue, 18 Apr 2006 17:08:53 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Apr 2006 21:08:54.0548 (UTC) FILETIME=[4CD69540:01C6632C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>
>On Maw, 2006-04-18 at 09:15 -0400, Tobias Oed wrote:
> > +       #if 0
> >         if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
> >                 return -1;
> > -
> > +       #endif
> > +
>
>This change looks unrelated to anything you are trying to do. Rest looks
>sane enough

Thing is, without it my machine hangs on boot, while talking to hde (cd
drive). Not sure why exactly.
Tobias

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

