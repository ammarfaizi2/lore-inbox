Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSIIP1B>; Mon, 9 Sep 2002 11:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSIIP1A>; Mon, 9 Sep 2002 11:27:00 -0400
Received: from ausadmmsps305.aus.amer.dell.com ([143.166.224.100]:60935 "HELO
	AUSADMMSPS305.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S317393AbSIIP1A>; Mon, 9 Sep 2002 11:27:00 -0400
X-Server-Uuid: bc938b4d-8e35-4c08-ac42-ea3e606f44ee
Message-ID: <20BF5713E14D5B48AA289F72BD372D6812BBC1@AUSXMPC122.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: degger@fhm.edu
cc: linux-kernel@vger.kernel.org
Subject: RE: [ANNOUNCE] devlabel: consistent device access through
 symlink ing
Date: Mon, 9 Sep 2002 10:31:37 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 116261511808385-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDs of firewire/USB device are handled the same as any other SCSI device.
First attempted is scsi inquiry page 83 followed by page 80.  If all else
fails, it will just write in the manufacturer name/model name as its ID.  
-Gary


-----Original Message-----
Except that for source RPMs sucking big time the stuff is REALLY cool!
I could also see benefits for other devices like HID where the current
ordering is done after a first come - first serve approach where the
minor device numbers follow the order the devices appear on the bus
which is quite easy to mess up and never consistent; Applying your
scheme to and-class devices also would allow to link whatever device
to a fixed device node which could solve many problems as far as
I can see.

Can you elaborate how you retrieve the IDs of a firewire or USB
controller?
 
-- 
Servus,
       Daniel

