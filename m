Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTIWO6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTIWO6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:58:09 -0400
Received: from lucidpixels.com ([66.45.37.187]:36045 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263373AbTIWO6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:58:07 -0400
Date: Tue, 23 Sep 2003 10:58:04 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 ide-scsi code broken
Message-ID: <Pine.LNX.4.58.0309231057350.11291@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Normally (2.4.0-2.4.21) I could burn 2 cds at the same time on seperate
IDE channels, now I cannow, back to 2.4.21 I go..

What changed????


 50.20% done, estimate finish Tue Sep 23 11:04:11 2003
cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 05 7D 89 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x24 Qual 0x00 (invalid field in cdb) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.000s timeout 40s
write track data: error after 736905216 bytes
Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00
cdrecord: Input/output error. close track/session: scsi sendcmd: no error
CDB:  5B 00 02 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 2C 04 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x2C Qual 0x04 (current program area is empty) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.000s timeout 480s
cmd finished after 0.000s timeout 480s

