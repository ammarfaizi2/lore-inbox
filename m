Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbRBLAcW>; Sun, 11 Feb 2001 19:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130823AbRBLAcM>; Sun, 11 Feb 2001 19:32:12 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:34488 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130781AbRBLAbz>; Sun, 11 Feb 2001 19:31:55 -0500
Date: Sun, 11 Feb 2001 16:31:17 -0800
From: Jerome Brock <jpbrock@pacbell.net>
Subject: Getting user input from the kernel?
To: "Linux-Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Message-id: <000a01c0948b$1d8fc420$0201a8c0@chinook>
MIME-version: 1.0
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
Importance: Normal
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Priority: 3 (Normal)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is a stupid question.

Is it possible to get user input from within the kernel?

I am trying to develop simple text-based user interface for a user to
perform some security critical actions, i.e. logging in.  Basically, I am
trying to implement a security manager that will be invoked via the magic
key sequence.  For all you security gurus this is a trusted path.

Once the user has invoked my kernel code, I believe I can use printk to
provide output to the user.  However, there is no equivalent scank.  How can
I get user input from the kernel?

Can this be done, or should I use the magic key sequence to launch a user
mode process that will implement the security manager I have in mind?  Also
does it make a difference whether I use kernel 2.2 or 2.4?

Thanks

Jerome




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
