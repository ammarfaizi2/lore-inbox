Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283506AbRLDOoc>; Tue, 4 Dec 2001 09:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283554AbRLDOmw>; Tue, 4 Dec 2001 09:42:52 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:30468 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S284381AbRLDOfD>; Tue, 4 Dec 2001 09:35:03 -0500
Message-Id: <4.3.2.7.2.20011204145737.034402c8@pop.xs4all.nl>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 04 Dec 2001 15:31:54 +0100
To: linux-poweredge@dell.com, linux-kernel@vger.kernel.org
From: Seth Mos <knuffie@xs4all.nl>
Subject: clock timer configuration lost on a ServerWorks Chipset
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a Dell PE2500 with 2 1.13Ghz processors and 2GB of ram and highmem 
enabled.
We are currently running Red Hat Linux 7.1 with a kernel compiled from 
kernel-source-2.4.9-12SGI_XFS_PR1
Which is the Red Hat Update kernel patched with XFS.

Nov 28 14:03:51 coltex-2 kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a motherboard.
Nov 28 14:03:51 coltex-2 kernel: probable hardware bug: restoring chip 
configuration.

These messages seem a bit odd. The PowerEdge 2500 has a Serverworks chipset 
so what is producing these
errors? They appear about once or twice a day.

I am not subscribed to the list.

00:00.0 Host bridge: ServerWorks CNB20HE (rev 23)
         Flags: fast devsel

00:00.1 Host bridge: ServerWorks CNB20HE (rev 01)
         Flags: bus master, medium devsel, latency 32

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
         Flags: medium devsel

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
         Flags: medium devsel


Cheers
--
Seth
Every program has two purposes one for which
it was written and another for which it wasn't
I use the last kind.

