Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbQLRMjS>; Mon, 18 Dec 2000 07:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131956AbQLRMjI>; Mon, 18 Dec 2000 07:39:08 -0500
Received: from mgw-x3.nokia.com ([131.228.20.26]:18078 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S131955AbQLRMjB>;
	Mon, 18 Dec 2000 07:39:01 -0500
Message-ID: <3A3DFD65.EBC5FDAA@yahoo.com>
Date: Mon, 18 Dec 2000 14:04:53 +0200
From: Bali <balitm@yahoo.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: psaux2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again!

I forgot to mention 2 other disadvantages:
- the write isn't supported in busmouse but it was in pc_keyb.c (i don't
know if it was used by any tool or not)
- Ther was a fasync fn call in psaux_release but fasync struct handled
in busmouse so i just commented it out but it works fine on my machine.


br,
Balázs Kilvády
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
