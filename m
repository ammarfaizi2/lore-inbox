Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWFVIeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWFVIeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWFVIeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:34:10 -0400
Received: from witte.sonytel.be ([80.88.33.193]:53395 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932387AbWFVIeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:34:09 -0400
Date: Thu, 22 Jun 2006 10:34:05 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [SCSI] audit drivers for incorrect max_id use
In-Reply-To: <200606211859.k5LIxxUh027415@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0606221033160.23155@pademelon.sonytel.be>
References: <200606211859.k5LIxxUh027415@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Linux Kernel Mailing List wrote:
> [SCSI] audit drivers for incorrect max_id use
> 
> max_id now means the maximum number of ids on the bus, which means it
> is one greater than the largest possible id number.

IMHO that's confusing.

Shouldn't it be renamed to max_num_ids?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
