Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317818AbSFMUam>; Thu, 13 Jun 2002 16:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317819AbSFMUal>; Thu, 13 Jun 2002 16:30:41 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:35590 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S317818AbSFMUak>; Thu, 13 Jun 2002 16:30:40 -0400
Message-Id: <200206132027.g5DKR4968416@aslan.scsiguy.com>
To: Paul P Komkoff Jr <i@stingr.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aic7xxx won't compile w/o PCI at all <- fixed 
In-Reply-To: Your message of "Thu, 13 Jun 2002 23:46:36 +0400."
             <20020613194636.GA26527@stingr.net> 
Date: Thu, 13 Jun 2002 14:27:04 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I know I shouldn't do that
>I also know someone should do at least compile on cases which affected by
>some patch.

I guess I'm missing some context here.

The patch, on first inspection, appears correct.  Unfortunately, finding
machines without PCI busses is getting more and more difficult every day,
but I'll add a build case that disables PCI busses so we catch these kinds
of failures in the future..

Thanks,
Justin
