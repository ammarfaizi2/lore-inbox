Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAPJHM>; Tue, 16 Jan 2001 04:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbRAPJHC>; Tue, 16 Jan 2001 04:07:02 -0500
Received: from james.kalifornia.com ([208.179.0.2]:21562 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129523AbRAPJGy>; Tue, 16 Jan 2001 04:06:54 -0500
Message-ID: <3A640F2A.E326922F@linux.com>
Date: Tue, 16 Jan 2001 01:06:50 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.0-ac6, 'rm' stalls in wait_on_buffer
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has this issue been addressed?  When I delete something large..say a
mozilla cvs tree, rm will stall for about 10-30 seconds every few
minutes in wait_on_buffer.

It's an IDE drive, nothing fancy on the system, it's a standard pII w/
256 megs, about 50megs free.  'sync' also stalls similarly.

Ideas?

-d

--
..NOTICE fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
