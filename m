Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTFTN5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTFTN5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:57:25 -0400
Received: from windsormachine.com ([206.48.122.28]:16915 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S262256AbTFTN5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:57:21 -0400
Date: Fri, 20 Jun 2003 10:11:08 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Arnaud Ligot <spyroux@freegates.be>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: xircom card bus with 2.4.20 link trouble
In-Reply-To: <1056101193.6728.14.camel@portable>
Message-ID: <Pine.LNX.4.33.0306201007470.15589-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 2003, Arnaud Ligot wrote:

> Hello,
>
> Since I run the 2.4.20 kernel (+bootsplash patch), (I didn't try without
> this patch but I think it is not the problem), my Xircom Cardbus don't
> work any more! In fact, I put the card into the pcmcia slot, the pc
> detect it, load the correct module (xirc2ps_cb), start eth1 but the led
> link (both side) blinks.
> I have try with a hub 10, a ethernet card 10 and an ethernet card
> 10/100. I have so try 2 cables... but same problem.
> I have try to impose the ethernet type of link mii-tool -A10BaseT-HD and
> -F10BaseT-HD.
>
> Thanks
>
> Arnaud

Mine doesn't work either, I have a RBEM56G-100.

Bought this off ebay for quite cheap to replace my REM56G-100.

It detects it, etc etc, but never actually works.

I put the REM56G-100 back in, insmod'd the driver, and back in business.

I haven't tried a 2.5.x kernel, nor a 2.4.21(it's on my list of things to
do)

I was using the xircom_cb driver though.  The xircom_tulip_cb didn't work
either.

Mike

