Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSIAUPW>; Sun, 1 Sep 2002 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSIAUPW>; Sun, 1 Sep 2002 16:15:22 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:3539 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317482AbSIAUPW>; Sun, 1 Sep 2002 16:15:22 -0400
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
From: Martin Wilck <mwilck@freenet.de>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: Greg KH <greg@kroah.com>, marcelo@conectiva.com.br,
       mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org
In-Reply-To: <E17kPnl-0003aD-00@alf.amelek.gda.pl>
References: <E17kPnl-0003aD-00@alf.amelek.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Sep 2002 22:19:37 +0200
Message-Id: <1030911578.17142.1.camel@odysseus.mittagstun.de>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2002-08-29 um 15.57 schrieb Marek Michalkiewicz:
> > > /* aka Sagatek DCS-CF */
> > > UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
> > > 		"Datafab",
> > > 		"KECF-USB",
> > > 		US_SC_SCSI, US_PR_BULK, NULL,
> > > 		US_FL_FIX_INQUIRY ),

This works fine with 2.4.20 - congratulations!!
I wonder what happened to the SCSI inquiry - was it limited to 36 bytes?

Martin


