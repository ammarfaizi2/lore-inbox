Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130308AbQKXIKi>; Fri, 24 Nov 2000 03:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130880AbQKXIK2>; Fri, 24 Nov 2000 03:10:28 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:4876 "EHLO
        mail.harddata.com") by vger.kernel.org with ESMTP
        id <S130308AbQKXIKR>; Fri, 24 Nov 2000 03:10:17 -0500
Date: Fri, 24 Nov 2000 00:40:13 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: vm in 2.2.18pre23 - behaving worse
Message-ID: <20001124004013.A8944@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was busy with other things and did not track 2.2.18pre kernels very
carefuly, but now I tried 2.2.18pre23 on Alpha and got an impression
that a situation with a virtual memory handling is worse than it was,
say, in 2.2.18pre15.  I can now see in /var/log/messages entries like
"VM: killing process sh" or "VM: killing process emacs" because I was
compiling a kernel.  This does not happen consistently, predictably, or
very often but it does happen and I should not be oom.  Nothing else
crashes, or leaves any traces in log files, and a machine continues
apparently not disturbed, but a process is gone.

Applying patches from Andrea and the one from Rik, posted some week
ago under "blindingly stupid 2.2 VM bug" subject, does not seem
to help very much.  Sigh!

Am I isolated in this experience?

  Michal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
