Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130549AbRAOXcI>; Mon, 15 Jan 2001 18:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131039AbRAOXbs>; Mon, 15 Jan 2001 18:31:48 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:19724 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S130792AbRAOXbh>;
	Mon, 15 Jan 2001 18:31:37 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: Oops with 4GB memory setting in 2.4.0 stable
Date: Tue, 16 Jan 2001 08:31:22 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGCENGCMAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3A637E15.DDC8C38@telemach.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I have a 100% reproducable bug in all of the 2.4.0 kernels including the
latest stable one. The issue is that if I compile the kernel to support 4GB
RAM (I have 1 GB) and then try to access a samba mount I get an oops. This
ALWAYS happens. Usually after this the system is frozen (although the magic
SYSREQ still works). If the system isn't frozen then any commands that
access the disk will freeze. Fortunately GPM worked and I was able to paste
the oops to a file via telnet.

	Attached is my oops.txt and the result sent through ksymoops. The results
don't look particularly useful to me so perhaps I'm doing something wrong.
PLEASE tell me if I should parse this differently. Likewise, if there is
anything else I can do to help debug this, please tell me.

--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
