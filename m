Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTFIOPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTFIOPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:15:19 -0400
Received: from aleph.net.uniovi.es ([156.35.11.1]:23312 "EHLO
	aleph.net.uniovi.es") by vger.kernel.org with ESMTP id S264336AbTFIOPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:15:16 -0400
Date: Mon, 09 Jun 2003 16:28:43 +0200
From: Luciano Campal Vazquez <lucho@coala.uniovi.es>
Subject: Problem with ACPI and batteries detection in 2.5.70.
To: linux-kernel@vger.kernel.org
Message-id: <20030609162843.7f4d27ef.lucho@coala.uniovi.es>
Organization: CoALA (Colectivo de Apoyo a Linux de Asturias)
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I own an Inspiron 8100, updated to the latest bios, A15, and i found problems with the
/proc/acpi/battery/BAT1/info, it reports strage values, and gives some error messages.

In the syslog appears...

Isengard kernel:         -0091: *** Error: ut_allocate: Attempt to allocate zero bytes

everything seems to be detected...

Jun  8 14:01:10 Isengard kernel: ACPI: AC Adapter [AC] (off-line)
Jun  8 14:01:10 Isengard kernel: ACPI: Battery Slot [BAT0] (battery absent)
Jun  8 14:01:10 Isengard kernel: ACPI: Battery Slot [BAT1] (battery present)
Jun  8 14:01:10 Isengard kernel: ACPI: Processor [CPU0] (supports C1 C2)

I cannot reboot now in 2.5.70, so i cannot paste you the output of the "cat /..../info" but maybe this little information is useful.

Bye.

-- 
 __________________________________________
|                                          |
|         Luciano Campal Vazquez           |
|                 CoALA                    |
| (Colectivo de Apoyo a Linux de Asturias) |
|                                          |
|         lucho@coala.uniovi.es            |
|    http://www.coala.uniovi.es/~lucho     |
|__________________________________________|
