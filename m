Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263036AbTCLEur>; Tue, 11 Mar 2003 23:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263037AbTCLEur>; Tue, 11 Mar 2003 23:50:47 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1284 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263036AbTCLEuq>; Tue, 11 Mar 2003 23:50:46 -0500
Date: Tue, 11 Mar 2003 21:01:25 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: scott thomason <scott-kernel@thomasons.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
In-Reply-To: <200303112055.31854.scott-kernel@thomasons.org>
Message-ID: <Pine.LNX.4.10.10303112100270.391-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That has to be a BIO bug or IDE setup bug.

256 sectors is legal and correct for 28-bit addressing.

Cheers,

On Tue, 11 Mar 2003, scott thomason wrote:

> I frequently receive this message in my syslog, apparently 
> whenever there are periods of significant write activity:
> 
>     bio too big device ide0(3,7) (256 > 255)
>     bio too big device ide1(22,6) (256 > 255)
> 
> It's worth noting that on this system I have had ongoing trouble 
> with system stability during write activity as well, using a 
> wide variety of 2.5.x kernels, even though at the time of this 
> symptom things are apparently running fine.
> 
> Filesystems are all ext3 on top soft raid0 devices. This happens 
> to be 2.5.64, but it has been happening for at least the last 
> 5-6 versions.
> 
> Ideas? Any further debugging output I can provide?
> ---scott
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

