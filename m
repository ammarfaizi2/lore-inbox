Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262746AbREONBT>; Tue, 15 May 2001 09:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbREONBI>; Tue, 15 May 2001 09:01:08 -0400
Received: from www.topmail.de ([212.255.16.226]:57301 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S262746AbREONAy>;
	Tue, 15 May 2001 09:00:54 -0400
From: mirabilos <eccesys@topmail.de>
To: <linux-kernel@vger.kernel.org>
Subject: rwsem, gcc3 again
Message-Id: <20010515125759.19134A5ABC2@www.topmail.de>
Date: Tue, 15 May 2001 14:57:59 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have got that patch with "movl %2,%%edx" and removing the tmp
and still cannot compile with the same error message I posted yesterday.
The problem seems to be that, with or without "inline", it seems to
put a reference into main.o of arch/i386/boot/compressed.
So I cannot test -ac9 :(

If anyone could find a (final or at least until gcc is fixed temporarily)
solution please please could either post or mail me?
Please no Cc: as I am on the list.

-mirabilos
-- 
by telnet
