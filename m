Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbTIQBlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 21:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbTIQBlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 21:41:03 -0400
Received: from [193.138.115.2] ([193.138.115.2]:60146 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262583AbTIQBlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 21:41:01 -0400
Date: Wed, 17 Sep 2003 03:39:17 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: Lincoln Dale <ltd@cisco.com>
cc: Vishwas Raman <vishwas@eternal-systems.com>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Incremental update of TCP Checksum
In-Reply-To: <5.1.0.14.2.20030917113553.02e3cd10@mira-sjcm-3.cisco.com>
Message-ID: <Pine.LNX.4.56.0309170338420.943@jju_lnx.backbone.dif.dk>
References: <3F6770CE.8040802@eternal-systems.com> <3F3C07E2.3000305@eternal-systems.com>
 <20030821134924.GJ7611@naboo> <3F675B68.8000109@eternal-systems.com>
 <Pine.LNX.4.53.0309161533030.30081@chaos> <3F6770CE.8040802@eternal-systems.com>
 <5.1.0.14.2.20030917113553.02e3cd10@mira-sjcm-3.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Sep 2003, Lincoln Dale wrote:

> At 06:35 AM 17/09/2003, Jesper Juhl wrote:
> >Personally I can't see that you have any other option. The way the
> >checksum is calculated information is lost, so it's impossible to
> >determine exactely what input generated the current output (the checksum).
> >Just as it is impossible to tell if the number 6 was generated from 2+2+2,
> >from 3*2 or from 3+3 or some other...  So I don't see what else you can do
> >except just recalculate the checksum from scratch. To try and determine
> >how your modification would affect the checksum would probably take far
> >longer than just re-calculating it.
>
> of course you can do an incremental checksum update.
> you know that if you're changing a field from (say) 0x22 to 0x11 then you
> can 'back out' the 0x22 and recalculate the checksum with 0x11.
>
> this is the whole rationale behind why its a _checksum_ and not a _CRC_.
>
> router(s) have taken advantage of incremental since day one.
>

I stand corrected.  Thank you for pointing that out.

Jesper Juhl <jju@dif.dk>

