Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282201AbRK1Xmx>; Wed, 28 Nov 2001 18:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282181AbRK1Xmq>; Wed, 28 Nov 2001 18:42:46 -0500
Received: from proxyserver.epcnet.de ([62.132.156.25]:41991 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S282197AbRK1Xli>; Wed, 28 Nov 2001 18:41:38 -0500
Date: Thu, 29 Nov 2001 00:40:27
From: jd@epcnet.de
To: linux-kernel@vger.kernel.org
Subject: statfs and reiserfs
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <24719656.avixxmail@nexx.epcnet.de>
In-Reply-To: <:inreplyto>
X-Mailer: avixxmail v1.2.0.0
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: :content; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after a call of statfs() on my kernel-2.4.8, reiserfs returns for the fields f_files and f_ffree in the struct statfs values of -1.

Other filesystems return 0 for unsupported fields in the struct statfs, e.g. smbfs.

Some manpages say "Fields that are undefined for a particular file system are set to -1" (e.g. NetBSD1.4.3A from May24,1995), other say "Fields that are undefined for a particular file system are set to 0" (latest man pages from LDP)

Now. What's right? who's wrong? who's right?

Greetings 

    Jochen Dolze

