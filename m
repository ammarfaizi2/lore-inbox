Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVGTT0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVGTT0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 15:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVGTT0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 15:26:43 -0400
Received: from pcp0011457276pcs.chrchv01.md.comcast.net ([69.250.122.81]:55229
	"EHLO mail.jettisonnetworks.com") by vger.kernel.org with ESMTP
	id S261448AbVGTT0i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 15:26:38 -0400
Message-Id: <200507201926.j6KJQW6L021545@mail.jettisonnetworks.com>
From: "David Lewis" <dlewis@vnxsolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: IDE PIIX vs libata piix with software raid
Date: Wed, 20 Jul 2005 15:26:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcWNYOuxU3cGr1aYSBCFI+RRhwr8DQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am developing a system using the Intel SE7520BD2 motherboard. It has an
ICH5 with two SATA ports and one PATA channel. I am able to drive the PATA
channel with either the normal PIIX IDE driver or the libata driver which I
am using for the SATA ports. Ultimately all 4 ports will be in use with the
md driver creating a stripe volume (RAID0) that spans a partition on each of
the 4 drives (not for boot).

My question is, what is the recommended driver to use for the PATA channel?
Is it better to let libata support both types of drives, or use the IDE
driver for the PATA? Searching I have found that the support is there in
libata for the PATA channel (and I have it working on the system), but I
can't find a clear recommendation on which driver is considered 'better' in
this situation.

Thanks!

David Lewis 
VNX Solutions, Inc
dlewis@vnxsolutions.com
703-286-6529 Main
703-637-1090 FAX
410-569-4025 Direct FAX
410-459-7428 Cell
 



