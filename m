Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278643AbRJXQn1>; Wed, 24 Oct 2001 12:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278604AbRJXQnB>; Wed, 24 Oct 2001 12:43:01 -0400
Received: from viper.haque.net ([66.88.179.82]:27777 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S278657AbRJXQly>;
	Wed, 24 Oct 2001 12:41:54 -0400
Date: Wed, 24 Oct 2001 12:42:27 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Tim Tassonis <timtas@cubic.ch>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <E15wQz4-0000Hs-00@lttit>
Message-ID: <Pine.LNX.4.33.0110241239230.5558-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, Tim Tassonis wrote:

> Well I do use hdparm -d 1 /dev/hda in init to set dma to 1. I know called
> hdparm -d 0 /dev/hda and tried again, but it still fails. Do you mean
> hdparm should not touch the device at all and a reboot without the hdparm
> -d 1 /dev/hda would do the job? I could live with that for the moment, as
> I don't have to repartition my drive very often...
>

Woops. hit send too fast.

You can use hdparm once you've repartitioned though it seems. Still
won't be able create any files >2GB once you've touched it with hdparm
again but at least you'll be up and running with whatever size
partitions you want and have dma enabled. Dunno if that's an issue.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Developer/Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

