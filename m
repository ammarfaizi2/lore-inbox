Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292373AbSCIBuK>; Fri, 8 Mar 2002 20:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292383AbSCIBuA>; Fri, 8 Mar 2002 20:50:00 -0500
Received: from ns.muni.cz ([147.251.4.33]:11172 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S292373AbSCIBtx>;
	Fri, 8 Mar 2002 20:49:53 -0500
To: linux-kernel@vger.kernel.org
Subject: ACPI hangs on boot with K7SEM MoBo and Adaptec SCSI card
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 09 Mar 2002 02:49:49 +0100
Message-ID: <qww3czaldc2.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got ECS K7SEM motherboard. ACPI power saving is enabled in BIOS
and works in linux (at least halt turns the box off). However when I
plug in Adaptec SCSI (2940AU) the machine hangs during boot after
loading ACPI core subsystem. The last message is:
ACPI: core subsystem version [20011018]

I have 2.4.19-pre2-ac3 with both ACPI and APM compiled in.  I am booting
with apm=off (otherwise acpi does not load).

It's not really critical, since apm works too. I just thought I would
have access to all the acpi goodies like temperature of the CPU.

                                                Take care, Petr
-- 
No chinese, no fortune.
