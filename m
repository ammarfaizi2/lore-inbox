Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWCSX5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWCSX5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 18:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCSX5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 18:57:11 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:44524
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751225AbWCSX5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 18:57:10 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: linux-kernel@vger.kernel.org
Subject: kernel hda errors on dmesg
Date: Sun, 19 Mar 2006 17:57:09 -0600
Message-Id: <20060319235255.M28695@linuxwireless.org>
In-Reply-To: <17915ac50603180054l4c3c6646ifcdee47e8f76887c@mail.gmail.com>
References: <20060318081134.M30026@linuxwireless.org> <17915ac50603180054l4c3c6646ifcdee47e8f76887c@mail.gmail.com>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 200.91.133.131 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an Compaq V2000 laptop with Ubuntu Dapper Drake, I'm getting flooded 
with the messages below: 
ON: Linux ubuntu 2.6.15-18-386 #1 PREEMPT Thu Mar 9 14:41:49 UTC 2006 i686 
GNU/Linux 
/dev/sda: FUJITSU MHV2060BH:

Why am I getting hda errors when I don't even have a hda drive? Mine is sda.
The syslog says is the kernel itself, no other application is causing this as
I have stopped most services and still happen.

I already wrote to the Ubuntu ML but had no luck. 

Any idea?

dmesg

[4295643.338000] ide: failed opcode was: 0xef 
[4295644.283000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq: 0x00 
[4295644.295000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq: 0x00 
[4295645.963000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq: 0x00 
[4295645.966000] hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error } 
[4295645.966000] hda: drive_cmd: error=0x04 { AbortedCommand } 
[4295645.966000] ide: failed opcode was: 0xec 
[4295646.000000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30  ascq: 0x00 
[4295646.003000] hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error } 
[4295646.003000 ] hda: drive_cmd: error=0x04 { AbortedCommand } 
[4295646.003000] ide: failed opcode was: 0xec 
[4295646.345000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30  ascq: 0x00 
[4295646.357000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30  ascq: 0x00 
[4295648.408000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq: 0x00 
[4295648.421000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq: 0x00 
[4295650.471000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30   ascq: 0x00 
[4295650.483000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq: 0x00 
[4295652.534000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq: 0x00 
[4295652.546000] hda: error code: 0x70  sense_key: 0x02  asc: 0x30   ascq: 0x00 
[4295654.601000] hda: error code: 0x70  sense_key: 0x02   asc: 0x30  ascq: 0x00 
[4295654.612000] hda: error code: 0x70   sense_key: 0x02  asc: 0x30  ascq: 0x00

Thanks,

.Alejandro


