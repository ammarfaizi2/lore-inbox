Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278152AbRJLVbE>; Fri, 12 Oct 2001 17:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278153AbRJLVay>; Fri, 12 Oct 2001 17:30:54 -0400
Received: from c1052869-a.smateo1.sfba.home.com ([24.7.95.44]:31507 "HELO
	mail.desbiens.org") by vger.kernel.org with SMTP id <S278152AbRJLVah>;
	Fri, 12 Oct 2001 17:30:37 -0400
Date: Fri, 12 Oct 2001 14:31:03 -0700 (PDT)
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: SOLVED: USB lockup on Thinkpad i1300
Message-ID: <Pine.LNX.4.10.10110121429470.17342-100000@router.internal.desbiens.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that ACPI must be enabled for USB support to work on an IBM
Thinkpad i1300. ACPI also fixes the rather strange problem where the BIOS
will mis-read the CMOS data when rebooting.

I figure there's some bugfix code in the ACPI _INI stuff on these
machines.

Hope this helps people!

Taral

