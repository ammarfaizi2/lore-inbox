Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129640AbQKUPWq>; Tue, 21 Nov 2000 10:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbQKUPWg>; Tue, 21 Nov 2000 10:22:36 -0500
Received: from [206.206.98.15] ([206.206.98.15]:45073 "EHLO mail2.thuntek.net")
	by vger.kernel.org with ESMTP id <S129640AbQKUPWW>;
	Tue, 21 Nov 2000 10:22:22 -0500
Message-ID: <002f01c053ca$cc6a6d80$0200a8c0@ruby>
From: "Ron L. Smith" <hunter@thuntek.net>
To: <linux-kernel@vger.kernel.org>
Subject: Quota files on root FS get "too large" error after 2.4.x upgrade
Date: Tue, 21 Nov 2000 07:53:23 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After installing and configuring kernel 2.4.0-test11, all is working well,
except quota's on the root FS.  I am at a loss as to how to correct this:

ls -l /quota.*
ls: /quota.group: Value too large for defined data type
ls: /quota.user: Value too large for defined data type

rm -f /quota.*
rm: cannot remove `/quota.group': Value too large for defined data type
rm: cannot remove `/quota.user': Value too large for defined data type

I have just started testing with the 2.4.x series kernel, so do not know if
this would have been seen in any previous testxx version.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
