Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbRADK27>; Thu, 4 Jan 2001 05:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbRADK2t>; Thu, 4 Jan 2001 05:28:49 -0500
Received: from [213.166.15.20] ([213.166.15.20]:5896 "EHLO mail.fsbdial.co.uk")
	by vger.kernel.org with ESMTP id <S129572AbRADK2f>;
	Thu, 4 Jan 2001 05:28:35 -0500
Message-ID: <3A54502F.6039978E@FreeNet.co.uk>
Date: Thu, 04 Jan 2001 10:27:59 +0000
From: Sid Boyce <sidb@FreeNet.co.uk>
Reply-To: sidb@FreeNet.co.uk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: prerelease-ac5 make dep error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Just seen this on UP kernel build.....
/usr/src/linux/scripts/mkdep  > .depend
make _sfdep_acpi _sfdep_atm _sfdep_block _sfdep_cdrom _sfdep_char
_sfdep_dio _sfdep_fc4 _sfdep_i2c _sfdep_ide _sfdep_ieee1394 _sfdep_input
_sfdep_isdn _sfdep_macintosh _sfdep_md _sfdep_media
_sfdep_message/fusion _sfdep_message/i2o _sfdep_misc _sfdep_mtd
_sfdep_net _sfdep_net/hamradio _sfdep_nubus _sfdep_parport _sfdep_pci
_sfdep_pcmcia _sfdep_pnp _sfdep_sbus _sfdep_scsi _sfdep_sgi _sfdep_sound
_sfdep_tc _sfdep_telephony _sfdep_usb _sfdep_video _sfdep_zorro
_FASTDEP_ALL_SUB_DIRS="acpi atm block cdrom char dio fc4 i2c ide
ieee1394 input isdn macintosh md media message/fusion message/i2o misc
mtd net net/hamradio nubus parport pci pcmcia pnp sbus scsi sgi sound tc
telephony usb video zorro"
make[3]: Entering directory `/usr/src/linux/drivers'
make -C acpi fastdep
make[4]: Entering directory `/usr/src/linux/drivers/acpi'
/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS'
references itself (eventually).  Stop.
make[4]: Leaving directory `/usr/src/linux/drivers/acpi'
make[3]: *** [_sfdep_acpi] Error 2
make[3]: Leaving directory `/usr/src/linux/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [dep-files] Error 2
Regards
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop.. Tel. 44-121 422 0375
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
