Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTFITSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTFITSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:18:11 -0400
Received: from fmr01.intel.com ([192.55.52.18]:50417 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264455AbTFITSK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:18:10 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DA16CB0@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: RE: Patches for SCSI timeout bug
Date: Mon, 9 Jun 2003 12:31:42 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Anton Blanchard [mailto:anton@samba.org]
> 
> > 2) By incresing the sym53c8xx post-reset delay to at least
> >    12 seconds.
> >
> > Fix 2) may not be bad: I have at least one scsi hard drive which
> > takes 5 seconds to recover from a bus reset.   On the other hand,
> > fix 2) makes the boot process longer: it introduces a delay of
> > N x 12 seconds, where N is the number of scsi channels.
> > (Most cards have two channels; some server-class machines with
> > many cards may have a significantly longer boot).
> 
> Yep, Ive got a box with 42 scsi controllers and the time to probe SCSI
> is already unbearable :)

Woah, can I see a copy of your electricity bill? That must suck
amps...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
