Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133036AbRAQLmc>; Wed, 17 Jan 2001 06:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133039AbRAQLmN>; Wed, 17 Jan 2001 06:42:13 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:57101 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S133036AbRAQLlx>; Wed, 17 Jan 2001 06:41:53 -0500
Date: Wed, 17 Jan 2001 11:42:11 +0000
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre8 and Athlon
Message-ID: <20010117114211.B1315@colonel-panic.com>
Mail-Followup-To: pdh, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Building 2.4.1-pre8 for K7 gives 'current' undefined errors in the headers
included from init/main.c. Looks like something included from asm/string.h
is missing an include. The problems go away if I remove
CONFIG_X86_USE3DNOW=y from the config.

P.

-- 
P. Horton
Software Engineer
http://www.colonel-panic.com
Linux 2.4.0
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
