Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbRBDLBt>; Sun, 4 Feb 2001 06:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRBDLBj>; Sun, 4 Feb 2001 06:01:39 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:30382 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S129480AbRBDLB0>; Sun, 4 Feb 2001 06:01:26 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <mathieu_dube@videotron.ca>, <linux-kernel@vger.kernel.org>
Subject: RE: accept
Date: Sun, 4 Feb 2001 03:01:24 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKGEICNHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <01020319433406.00125@grndctrl>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What does it typically mean when accept returns 0
> and that the perror outputs "Interupted system call"??

	Since 'accept' returning zero is not an error, the results of 'perror' are
meaningless. Please read the manual page for 'accept' and notice that it
says, "The call returns -1 on error". Continue reading to understand what a
return value of zero means. Remember that zero is a non-negative integer.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
