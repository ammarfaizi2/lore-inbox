Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKTR0M>; Mon, 20 Nov 2000 12:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQKTR0D>; Mon, 20 Nov 2000 12:26:03 -0500
Received: from [193.127.21.194] ([193.127.21.194]:36905 "HELO
	postal.sl.trymedia.com") by vger.kernel.org with SMTP
	id <S129189AbQKTRZw>; Mon, 20 Nov 2000 12:25:52 -0500
From: Rubén Gallardo Fructuoso <ruben@trymedia.com>
To: <linux-kernel@vger.kernel.org>
Subject: Sharing memory between processes in kernel mode
Date: Mon, 20 Nov 2000 17:58:33 +0100
Message-ID: <DLECJAOCHAKJBLMJFKPIGENJCCAA.ruben@trymedia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

	I want to share memory between two differents processes in kernel mode. The
goal is to copy the read buffer of a user process into the read buffer of
another user process. I know it's possible to do it by creating an
intermediate buffer in kernel mode and to use the 'copy_from_memory' and
'copy_to_user' functions for copying data from a process to other, but this
is a slow method. Can I do it in a different way? Are there functions for
turning user space pointers into kernel space pointers without copying data?

	Thanks in advance,
	Rubén.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
