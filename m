Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTIOVUW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTIOVUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:20:21 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:27524 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261588AbTIOVUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:20:15 -0400
Date: Mon, 15 Sep 2003 23:19:59 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Olaf Hering <olh@suse.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre4: failed at atyfb_base.c
In-Reply-To: <20030915210421.GA311@suse.de>
Message-ID: <Pine.LNX.4.44.0309152308410.24675-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Sep 2003, Olaf Hering wrote:

> pre4 doesnt work on my ibook1, the xclk value is 125, but should be 50.

That is not correct. The default xclk for the Rage Mobility M1 is
125 MHz and this is indeed the case, for example on Geert's VAIO.
See also the e-mail below from Vernon Chiang from ATi.

On x86, I usually ask a copy of the video driver to be able to check the
driver information table of that particular implementation. Do you have
something similair from the Open Firmware?

Greetings,

Daniël Mantione


Date: Mon, 6 May 2002 14:51:47 -0400
From: ATI Developer Relations <devrel@ati.com>
To: 'Daniël Mantione' <daniel@deadlock.et.tudelft.nl>
Subject: RE: Memory clock on Rage mobility
Parts/Attachments:
   1   OK    ~47 lines  Text
   2 Shown   ~84 lines  Text
----------------------------------------


Hi Daniel,

I've gotten confirmation that the Rage Mobility P/M engine/clock setting
should be
125MHz/83MHz.

The ltmodset program is correct.

Thanks.

Regards,

Vernon Chiang
ATI Developer Relations
devrel@ati.com





