Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283479AbRLDVou>; Tue, 4 Dec 2001 16:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283524AbRLDVoa>; Tue, 4 Dec 2001 16:44:30 -0500
Received: from stud.tb.fh-muenchen.de ([129.187.138.35]:13697 "EHLO
	server.intern.stud.fh-muenchen.de") by vger.kernel.org with ESMTP
	id <S283512AbRLDVoU>; Tue, 4 Dec 2001 16:44:20 -0500
Subject: ACPI / APM - Battery level not readable on HP Omnibook XE3
From: Lars Duesing <ld@stud.fh-muenchen.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Dec 2001 22:44:11 +0100
Message-Id: <1007502251.13475.1.camel@ws1.intern.stud.fh-muenchen.de>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I do have some nice problem.
I got a new Omnibook XE3/1066, and wanted to install Linux.
Problems are growing big :)

All information regards to kernel 2.5.0.

One of my Problems is: I cannot read battery-level trough either acpi
nor apm.
On acpi kernel tells me on cat /proc/acpi/battery/1/info:
Present:		yes
Design Capacity:	5400 mAh
Last Full Capacity:	5400 mAh
...
Model Number:		LIP9071
...
Battery Type:		LiON
OEM Info:		HP

so far so good.
cat /proc/acpi/battery/1/status:
Present:		yes
Error reading battery status (_BST)

ouch.
best thing - next cat /proc/acpi/battery/1/info:
Present:		yes
Error reading battery information (_BIF)

double ouch.

Using APM results are more or less the same.

any hints?

thanks

	Lars Duesing




