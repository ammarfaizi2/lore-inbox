Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSKMTZJ>; Wed, 13 Nov 2002 14:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSKMTZJ>; Wed, 13 Nov 2002 14:25:09 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:63888 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S262580AbSKMTZI>;
	Wed, 13 Nov 2002 14:25:08 -0500
Date: Wed, 13 Nov 2002 14:32:00 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: sensors.conf for winbond/amd system
Message-ID: <20021113193200.GL2226@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Finally got sensors up and happy, looks very nice except for a few
things such as the readings on my cpu/board temps.

  I'm digging through the sensors.conf very slowly but I'm wondering if
someone with a similar config can send me thiers if they've tweaked and
tuned it.  Yeah it might not be "right" but it would give me another
datapoint to look at.

For reference:
--------------------------------------------------------
root@rharris-build1.acs:~# sensors
w83627hf-i2c-0-2c
Adapter: SMBus AMD768 adapter at 80e0
Algorithm: Non-I2C SMBus adapter

root@rharris-build1.acs:~# lsmod
Module                  Size  Used by
w83781d                21252   0  (unused)
i2c-proc                6608   0  [w83781d]
i2c-amd756              3844   0
i2c-dev                 4236   0
--------------------------------------------------------

Thanks,
  Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'

