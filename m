Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280998AbRKGV1Y>; Wed, 7 Nov 2001 16:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280997AbRKGV1L>; Wed, 7 Nov 2001 16:27:11 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:48909 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S280991AbRKGV0w> convert rfc822-to-8bit; Wed, 7 Nov 2001 16:26:52 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "Zvi Har'El" <rl@math.technion.ac.il>
Subject: Re: ext3 vs resiserfs vs xfs
Date: Wed, 7 Nov 2001 22:25:12 +0100
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.33.0111072302460.12525-100000@leeor.math.technion.ac.il>
In-Reply-To: <Pine.GSO.4.33.0111072302460.12525-100000@leeor.math.technion.ac.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E161aDV-0005fn-00@mrvdom01.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /dev/root / ext2 rw 0 0
> /dev/hda6 /home ext3 rw 0 0
>
> However, tune2fs -l on both /dev/hda1 (the root filesystem) and /dev/hda6
> gives Filesystem features:      has_journal sparse_super

You don use ext3.
ext3 is backward compatible with ext2. So you can mount ext3 as ext2 
completely ignoring the journal.

Look for a line in /etc/fstab
/dev/root and change the file system to ext3.

greetings 

Christian Bornträger
