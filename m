Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbQLTUF5>; Wed, 20 Dec 2000 15:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbQLTUFs>; Wed, 20 Dec 2000 15:05:48 -0500
Received: from pc198-cam3.cable.ntl.com ([62.253.134.198]:45317 "EHLO
	fireball.dragon") by vger.kernel.org with ESMTP id <S129819AbQLTUF1> convert rfc822-to-8bit;
	Wed, 20 Dec 2000 15:05:27 -0500
Date: Wed, 20 Dec 2000 19:29:50 +0000 (GMT)
From: Rob Adamson <r.adamson@hotpop.com>
To: Robert Högberg <robho956@student.liu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Extreme IDE slowdown with 2.2.18
In-Reply-To: <3A40E1B1.88008025@student.liu.se>
Message-ID: <Pine.LNX.4.21.0012201927330.866-100000@purple.dragon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Robert Högberg wrote:

> I'm having problems with the performance of my harddrives after I
> upgraded my kernel from 2.2.17 to 2.2.18.
> The performancedrop is noticable on every IDE drive.

[snip]
> Does anyone know what could be wrong? Have I forgot something? Is this a
> known problem with the 2.2.18 kernel?

Is DMA enabled on the hard drives?
Did you turn on "Use DMA by default" in the kernel configuration?
Did you compile in DMA support (if needed)?

What is the output of "hdparm /dev/hda /dev/hdb /dev/hdc" ?


Rob Adamson.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
