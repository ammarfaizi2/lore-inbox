Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269434AbRHGU4A>; Tue, 7 Aug 2001 16:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269433AbRHGUzu>; Tue, 7 Aug 2001 16:55:50 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:65460 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S269434AbRHGUzj>; Tue, 7 Aug 2001 16:55:39 -0400
Date: Tue, 7 Aug 2001 16:55:50 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eepro100.c - Add option to disable power saving in
 2.4.7-ac7
In-Reply-To: <3B6EBC34.9578EA4E@TeraPort.de>
Message-ID: <Pine.LNX.4.10.10108071655190.4770-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Aug 2001, Martin Knoblauch wrote:

> Hi,
> 
>  after realizing that my first attempt for this patch was to
> enthusiastic, I have no a somewhat stripped down version. Compiles
> against 2.4.7-ac7.
> 
>  The patch adds the option "power_save" to eepro100. If "1" (default),
> power save handling is done as normal. If "0", no power saving is done.
> This is to workaround some flaky eepro100 adapters that do not survive
> D0->D2-D0 transitions.
> 

i'm assuming if APM isn't configured in the kernel, these options dont
matter?

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

