Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVAQNfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVAQNfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVAQNfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:35:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:1483 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262795AbVAQNfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:35:31 -0500
Date: Mon, 17 Jan 2005 14:35:30 +0100 (MET)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.10-rc1-bk4/i386] app hangs and tasklisk corruption
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <13732.1105968930@www18.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i am test driving the bitkeeper snapshot from last night
and found strangs application hangs when compling e.g. gcc.
the problem happens with gcc and with the configure scripts.
when getting hung, the application wont respond to ctrl-c
anymore, but can be killed from a separate shell. despite
this temporary success, in the long term the task list gets
increasingly corrupt (like showing wrong users or even tasks
arent existing anymore) so that proceeding gets a mess.

I dont know if todays snapshop will improve anynthing
in that area and i am not sure if i will test that. 
the kernel i lasted tested was 2.6.11-rc1-bk1 which
behaved as it should. my testing platform has 2 cpus.

-Alex.

PS: please CC me on replys. (i read the list only via MARC.)

-- 
GMX im TV ... Die Gedanken sind frei ... Schon gesehen?
Jetzt Spot online ansehen: http://www.gmx.net/de/go/tv-spot
