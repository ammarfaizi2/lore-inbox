Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278653AbRJXQkH>; Wed, 24 Oct 2001 12:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278643AbRJXQjx>; Wed, 24 Oct 2001 12:39:53 -0400
Received: from viper.haque.net ([66.88.179.82]:25985 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S278652AbRJXQiq>;
	Wed, 24 Oct 2001 12:38:46 -0400
Date: Wed, 24 Oct 2001 12:39:15 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Tim Tassonis <timtas@cubic.ch>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <E15wQz4-0000Hs-00@lttit>
Message-ID: <Pine.LNX.4.33.0110241238340.5558-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, Tim Tassonis wrote:

> > I'm able fdisk/mke2fs with 2.4.13-pre6 without the error so long as I
> > don't touch the device with hdparm.
>
> Well I do use hdparm -d 1 /dev/hda in init to set dma to 1. I know called
> hdparm -d 0 /dev/hda and tried again, but it still fails. Do you mean
> hdparm should not touch the device at all and a reboot without the hdparm
> -d 1 /dev/hda would do the job? I could live with that for the moment, as
> I don't have to repartition my drive very often...

Exactly. At least that's what I'm seeing here.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Developer/Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

