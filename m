Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129436AbQK2LLV>; Wed, 29 Nov 2000 06:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129449AbQK2LLM>; Wed, 29 Nov 2000 06:11:12 -0500
Received: from mail.winealley.com ([194.3.190.130]:8720 "HELO
        mail.winealley.com") by vger.kernel.org with SMTP
        id <S129436AbQK2LK7>; Wed, 29 Nov 2000 06:10:59 -0500
Message-ID: <3A24DDD1.D4731F6C@winealley.com>
Date: Wed, 29 Nov 2000 11:43:30 +0100
From: Jean-Luc Fontaine <jfontain@winealley.com>
Organization: Migratech
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4 test10 error reading from HP colorado 7/14 Gb tape
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me, thank you.

I can write just fine to the tape, but reading gives me the following
error:

# tar -tvf  /dev/ht0
ide-tape: ht0: I/O error, pc = 8, key = 5, asc = 2c, ascq = 0

A search on deja.com shows that I am not the only one to have
experienced this and that it did not occur with previous versions of
ide-tape.c. The same error occurs with a non-modular kernel build.

The machine is a i386 redhat 7.0, kernel compiled with egcs 1.1.2.

--
Jean-Luc Fontaine mailto:jfontain@winealley.com http://www.winealley.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
