Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936655AbWLCEJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936655AbWLCEJE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 23:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936656AbWLCEJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 23:09:04 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:64938 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S936655AbWLCEJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 23:09:01 -0500
Message-ID: <45724DDA.1020007@scientia.net>
Date: Sun, 03 Dec 2006 05:08:58 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CD/DVD drive errors and lost ticks
Content-Type: multipart/mixed;
 boundary="------------060300090203000405080309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300090203000405080309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi.

I have a Plextor PX-760A DVD/CD drive,.. and some days ago I've updated
to firmaware 1.05 (which is the most recent).
Since that I have problems reading many DVDs but this is not what I'm
asking here....

Some of the DVD-Videos work and I watched one some minutes ago.

Suddenly the soundoutput went crazy... totally disturbed with lots of
very high tones.

The crazy sound didn't stop although that may be bacause xine was locked
and I could not quit it,... I halted my system and after reboot the
crazy sound was away.

dmesg shows this:
Dec  3 04:12:16 euler kernel: hdb: irq timeout: status=0xd0 { Busy }
Dec  3 04:12:16 euler kernel: ide: failed opcode was: unknown
Dec  3 04:12:16 euler kernel: hdb: DMA disabled
Dec  3 04:12:16 euler kernel: hdb: ATAPI reset complete
Dec  3 04:12:18 euler kernel: hdb: irq timeout: status=0x80 { Busy }
Dec  3 04:12:18 euler kernel: ide: failed opcode was: unknown
Dec  3 04:12:18 euler kernel: hdb: ATAPI reset complete
Dec  3 04:20:05 euler kernel: warning: many lost ticks.
Dec  3 04:20:05 euler kernel: Your time source seems to be instable or
some driver is hogging interupts
Dec  3 04:20:05 euler kernel: rip _spin_unlock_irqrestore+0x8/0x30
Dec  3 04:51:49 euler kernel: hdb: irq timeout: status=0xd0 { Busy }
Dec  3 04:51:49 euler kernel: ide: failed opcode was: unknown
Dec  3 04:51:49 euler kernel: hdb: ATAPI reset complete
Dec  3 04:51:51 euler kernel: hdb: irq timeout: status=0x80 { Busy }
Dec  3 04:51:51 euler kernel: ide: failed opcode was: unknown
Dec  3 04:51:51 euler kernel: hdb: ATAPI reset complete


Any idea what the reason is? Could it be the firmware? Or a hardware
damage (if so which hardware is likely?)?

And what is tha lost ticks? How would a defect DVD/CD drive has
influence on the ticks (if that means CPU ticks).

Thanks,
Chris.

--------------060300090203000405080309
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------060300090203000405080309--
