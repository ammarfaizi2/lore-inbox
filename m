Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSKIRsn>; Sat, 9 Nov 2002 12:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262291AbSKIRsn>; Sat, 9 Nov 2002 12:48:43 -0500
Received: from 205-158-62-131.outblaze.com ([205.158.62.131]:18922 "HELO
	ws5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262129AbSKIRsl>; Sat, 9 Nov 2002 12:48:41 -0500
Message-ID: <20021109175520.30470.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 10 Nov 2002 01:55:20 +0800
Subject: contest results and ext3 corruptions
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
X-Habeas-Swe-1: winter into spring
X-Habeas-Swe-2: brightly anticipated
X-Habeas-Swe-3: like Habeas SWE (tm)
X-Habeas-Swe-4: Copyright 2002 Habeas (tm)
X-Habeas-Swe-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-Swe-6: email in exchange for a license for this Habeas
X-Habeas-Swe-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-Swe-8: Message (HCM) and not spam. Please report use of this
X-Habeas-Swe-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've just ran contest again 2.5.46, 
here the most intersting part of the results:

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              461.0   28      46      8       3.66
2.5.44 [3]              371.8   38      37      10      2.95
2.5.45 [1]              396.9   37      36      10      3.15
2.5.45-mcp3 [1]         557.5   25      49      9       4.42
2.5.46 [5]              809.1   20      81      10      6.42

What happened here ?

I'm using an ext3 fs and after the test I got this error message:
EXT3-fs error (device ide0(3,6)) in ext3_new_inode: error 28

startx didn't work anymore complaining about fixed font missing...

fsck.ext3 fixed the problem.

I hope it helps.

Ciao,
        Paolo
-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
