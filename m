Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbSKTNbh>; Wed, 20 Nov 2002 08:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbSKTNbh>; Wed, 20 Nov 2002 08:31:37 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:22228 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S266114AbSKTNbg>;
	Wed, 20 Nov 2002 08:31:36 -0500
Date: Wed, 20 Nov 2002 08:38:41 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: OT: Sensors not alarming?
Message-ID: <20021120133841.GU9163@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Got my sensors up and working in a fasion, I an have either
FAN/Motherboard Temp,and a few others OR the on CPU temps.  I'm going
with the CPU temps though and it looks pretty accurate now for this Tyan
board.  The only problem is I'm getting this:

lm75-i2c-0-4a                                                        
Adapter: SMBus AMD768 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
CPU Temp:  +65.5°C  (limit = +60.0°C, hysteresis = +50.0°C)

Could be me but I'm pretty sure 65 > 60 and should be in "ALARM" state.
I don't see a bit to toggle to tell it to alarm when over the limit.
The sensors has a setting for "temp_over" per "sensors -u" but it won't 
recognize "temp_max".  temp_over is set at 60.

Yes this sucker runs hot which is one of the concerns, most of my boxes
of this make are running a bit host but most are sitting around 48-54
degrees C.


Thoughts?


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'

