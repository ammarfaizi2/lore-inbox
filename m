Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270626AbTGNMko (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270607AbTGNMiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:38:22 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:64738 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S270615AbTGNMcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:32:03 -0400
Subject: ide-scsi junk on 2.6.0-test1
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank.Cornelis@elis.ugent.be
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 14 Jul 2003 14:46:50 +0200
Message-Id: <1058186810.1220.5.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using/testing 2.6.0-test1.
After a while I get 'hdc:lost interrupt' a few 100 times, ending with:

...
Jul 14 14:40:22 tom kernel: hdc: lost interrupt
Jul 14 14:40:22 tom kernel: ide-scsi: The scsi wants to send us more
data than expected - discarding data
Jul 14 14:40:22 tom kernel: hdc: lost interrupt
Jul 14 14:40:22 tom kernel: ide-scsi: The scsi wants to send us more
data than expected - discarding data
Jul 14 14:40:22 tom kernel: hdc: lost interrupt
Jul 14 14:40:22 tom kernel: ide-scsi: The scsi wants to send us more
data than expected - discarding data
Jul 14 14:40:22 tom kernel: hdc: irq timeout: status=0x80 { Busy }
Jul 14 14:40:22 tom kernel: hdc: DMA disabled
Jul 14 14:40:22 tom kernel: hdc: ATAPI reset complete
Jul 14 14:40:22 tom kernel: ide-scsi: The scsi wants to send us more
data than expected - discarding data
Jul 14 14:40:22 tom kernel: sr0: CDROM (ioctl) error, command: 0x43 00
00 00 00
00 00 00 0c 40
Jul 14 14:40:22 tom kernel: Current sr?: sense = 70  0
Jul 14 14:40:22 tom kernel: Raw sense data:0x70 0x00 0x00 0x00 0x00 0x00
0x00 0x0a 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00


