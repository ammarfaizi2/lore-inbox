Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbTBKP0Y>; Tue, 11 Feb 2003 10:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbTBKP0Y>; Tue, 11 Feb 2003 10:26:24 -0500
Received: from mail.ziplip.com ([128.242.109.119]:42031 "EHLO ziplip.com")
	by vger.kernel.org with ESMTP id <S261836AbTBKP0X>;
	Tue, 11 Feb 2003 10:26:23 -0500
Message-ID: <MLH4BXEKP5ICCBLRMHNZB4HVOGOMN5CPOFL4B0CK@ziplip.com>
Date: Tue, 11 Feb 2003 07:35:04 -0800 (PST)
From: machoamerica <machoamerica@ziplip.com>
Reply-To: machoamerica <machoamerica@ziplip.com>
To: linux-kernel@vger.kernel.org
Subject: reiserfs assumed over ext2?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ZLPwdHint: 
X-ZLExpiry: -1
X-ZLReceiptConfirm: N
X-Mailer: ZipLip v4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello there,
i'm using a machine with a 2.2.x kernel and ext2 partitions.  i compiled a new 2.4.x kernel with built-in ext2 and reiserfs support.  however, when i now try to boot the 2.4.x kernel i end up with "kernel panic" as it tries to mount my partitions as if they were reiserfs, and of course fails.  the 2.2.x kernel still works fine.

why is it assuming reiserfs over ext2 when support for both are compiled into the kernel?  my boot loader is lilo, is that where the problem lies?  please help.

-macho

