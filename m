Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280131AbRJaKoZ>; Wed, 31 Oct 2001 05:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280136AbRJaKoQ>; Wed, 31 Oct 2001 05:44:16 -0500
Received: from [195.66.192.167] ([195.66.192.167]:9742 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280131AbRJaKoC>; Wed, 31 Oct 2001 05:44:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: e2fsck bogus message
Date: Wed, 31 Oct 2001 12:43:29 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01103112432903.00794@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

e2fsck complains "Your /etc/fstab does not contain the fsck
passno field..." when there are no entries in /etc/fstab.
This message is bogus in this case.

Why I don't have any entries?
I refer to my root fs as /dev/root (thanks to devfs)
and I have nothing else to mount yet.
--
vda
