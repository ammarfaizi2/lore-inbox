Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTDIRO1 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 13:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTDIRO1 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 13:14:27 -0400
Received: from smtp03.web.de ([217.72.192.158]:12820 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263631AbTDIROZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 13:14:25 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: Process falls into uninterruptible sleep
Date: Wed, 9 Apr 2003 19:26:00 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304091926.00422.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a problem, since I'm using linux-2.4.21-pre6

Sometimes (there seems to be no reason for it) a process
(doesn't matter what process) falls into an
"uninterruptible sleep" while doing something with it.
This problem isn't reproducible or bound to a specific process.
It happens when it "want's to happen" :)

Here an example of a locked kmail:

mb@lfs:~> ps aux | grep kmail
mb       27979  0.2  8.8 43124 22728 ?       D    15:56   0:35 kmail

I'm not able to kill the processes.
I don't know if it is really a kernel-problem, but I think it is one.

Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

