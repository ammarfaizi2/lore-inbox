Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbTAMQSs>; Mon, 13 Jan 2003 11:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbTAMQSr>; Mon, 13 Jan 2003 11:18:47 -0500
Received: from static24-72-2-224.reverse.accesscomm.ca ([24.72.2.224]:7067
	"EHLO rapfast.petcom.com") by vger.kernel.org with ESMTP
	id <S267431AbTAMQSm>; Mon, 13 Jan 2003 11:18:42 -0500
From: Roe Peterson <roe@rapfast.petcom.com>
Message-Id: <200301131627.h0DGRX101413@rapfast.petcom.com>
Subject: Dell precision M50 and _very_ slow process startup
To: linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2003 10:27:32 -0600 (CST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After _quite_ a bit more investigation, and some good pointers from
the net (thanks, all!), this has turned out _not_ to be a problem
with swapping/paging at all.

For some reason, the magicdev process slows the system to a crawl!

I'm guessing that this process watches for cd insertion, changes
to home directory, et. al.

There seems to be no man page or info for magicdev itself.

Does anyone know more about this beast?

I've solved the problem temporarily by simply renameing
/usr/bin/magicdev...


