Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWC0O63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWC0O63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 09:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWC0O63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 09:58:29 -0500
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:41117 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1751059AbWC0O62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 09:58:28 -0500
Subject: Re: AverMedia 6 Eyes AVS6EYES driver
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Samuelsson <sam@home.se>
In-Reply-To: <20060327123757.6e06cf8a.sam@home.se>
References: <20060327123757.6e06cf8a.sam@home.se>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 09:52:28 -0500
Message-Id: <1143471148.2912.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew / all,

On Mon, 2006-03-27 at 12:37 +0200, Martin Samuelsson wrote:
> This time, I bring you a somewhat larger patch than the previous one.
> It adds support for the AverMedia AVS6EYES Zoran-based MJPEG card. And
> it's not base64 encoded. Sorry about that one.
[..]
> http://sam.kfib.org/sixeyes/linux-2.6.16-avs6eyes.diff
[..]
> It modifies drivers/media/video/Kconfig,
>             drivers/media/video/Makefile,
>             drivers/media/video/zoran_card.c,
>             drivers/media/video/zoran.h,
>             Documentation/video4linux/Zoran

I've reviewed those modifications, along with the new i2c modules
(ks0127 and bt866), and they're all up-to-standard. I recommend that
those patches be applied to the kernel tree. With those patches, a new
type of card will be supported in the kernel driver.

>         and include/linux/i2c-id.h
> The latter defines two experimental I2C_DRIVERIDs; not suited for real
> usage, but I'm not sure about how to obtain official ones.

(I think people commonly just append their IDs to the list at the bottom
of i2c-id.h, incrementally; at least, that's what I did when I submitted
earlier patches.)

Cheers,
Ronald

