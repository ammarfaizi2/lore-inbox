Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315335AbSFCMnm>; Mon, 3 Jun 2002 08:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSFCMnl>; Mon, 3 Jun 2002 08:43:41 -0400
Received: from ns.tasking.nl ([195.193.207.2]:22024 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S315335AbSFCMnk>;
	Mon, 3 Jun 2002 08:43:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15611.25585.983668.744210@koli.tasking.nl>
Date: Mon, 3 Jun 2002 14:41:21 +0200
To: linux-kernel@vger.kernel.org
From: Kees Bakker <rnews@altium.nl>
Subject: ov511 compilation failure 2.5.18 - struct urb has no next
X-Mailer: VM 7.03 under Emacs 20.7.2
Reply-To: kees.bakker@altium.nl (Kees Bakker)
Organisation: ALTIUM Software B.V.
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.5.18 I'm getting compilation errors in ov511.c.
ov511.c: In function `ov51x_init_isoc':
ov511.c:3978: structure has no member named `next'
ov511.c:3980: structure has no member named `next'

Struct member 'next' has been removed from struct urb.

Can I simply remove these lines that setup this 'ring'?
-- 
