Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130669AbRACVys>; Wed, 3 Jan 2001 16:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130701AbRACVyh>; Wed, 3 Jan 2001 16:54:37 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:16646 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130669AbRACVy2>; Wed, 3 Jan 2001 16:54:28 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-prelease freezes on serial event
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 03 Jan 2001 21:53:50 +0000
Message-ID: <m2n1d8jo9d.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My 2.4.0-prerelease freezes solid on certain serial port events. The
ones I have seen (and are both repeatable) are when powering off the
modem and powering it on causes the system to hang solid. Also if an
incoming call is received on the telephone, the system hangs ( I
assume that this is when the modem sends 'RING' and asserts the RI
hardware signal.)

The serial port is used only for outgoing connections and there is NO
getty process listening on it. 

I would suspect a hardware problem, except that I have never seen this
before and on reverting to 2.4.0-test12 these actions do not cause any
problems.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
