Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269743AbUJGH0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269743AbUJGH0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 03:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269744AbUJGH0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 03:26:12 -0400
Received: from relay-6m.club-internet.fr ([194.158.104.45]:32975 "EHLO
	relay-6m.club-internet.fr") by vger.kernel.org with ESMTP
	id S269743AbUJGH0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 03:26:07 -0400
Date: Thu, 7 Oct 2004 09:26:02 +0200
From: =?iso-8859-1?Q?S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@loria.fr>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Samuel Thibault'" <samuel.thibault@ens-lyon.org>,
       rmk@arm.linux.org.uk,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] new serial flow control
Message-ID: <20041007072601.GA947@galois>
References: <043c01c4ac0d$2c8bac80$294b82ce@stuartm> <1097113651.6013.8.camel@at2.pipehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1097113651.6013.8.camel@at2.pipehead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I haven't seen this style of flow control before. What uses it?
> 
> terminal visio-braille (TVB)
> A device for the sight impaired.

Just to give a litle bit more precise information: this braille terminal
has been designed more than 10 years ago by the Handialog socity which is
now part of the TechniBraille/United Vision group.
Modern VisioBra"lles (with Prom of version 4 or higher) support both a
standard serial port management, and this odd flow control which was
originally designed to be used under MS-DOS, and was appropriate for doing
polling.

The integration of Samuel's patch into the kernel would allow users of
teominals containing a PROM older than 4 to use brltty with their terminal,
which would be a very useful thing, because updating such a PROM has a very
high cost.

Sébastien.
