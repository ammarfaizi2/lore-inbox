Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSFXUGj>; Mon, 24 Jun 2002 16:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSFXUGi>; Mon, 24 Jun 2002 16:06:38 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:59919 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315222AbSFXUGh>; Mon, 24 Jun 2002 16:06:37 -0400
Subject: Automatically mount or remount EXT3 partitions with EXT2 when a
	laptop is powered by a battery?
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 24 Jun 2002 13:02:26 -0700
Message-Id: <1024948946.30229.19.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any possibility we could:

1)  Add support to the boot/mounting process 
    so that, if a machine is being powered by
    battery, EXT3 partitions are mounted with
    EXT2, instead?

2)  While the machine is running, notice when the
    power source switches between AC and battery
    or vice versa and remount partitions EXT3
    partitions to use EXT2 whenever a battery is
    being used?

This could save laptop users a lot of power,
while keeping the benefits of EXT3 when AC
power is available.

I know that this can be accomplished with more
direct user intervention, but I am hoping a more
general and transparent solution can be created.

	Miles

