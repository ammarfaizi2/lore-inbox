Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270971AbTHFTkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270967AbTHFTkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:40:14 -0400
Received: from post.tau.ac.il ([132.66.16.11]:13277 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S270971AbTHFTkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:40:00 -0400
Subject: suspend fails under load
From: Micha Feigin <michf@post.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060178056.1390.4.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 06 Aug 2003 22:41:51 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.20.0.1; VDF: 6.20.0.55; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under kernel 2.6.0-test2 I get the behaviour that when trying to suspend
under load, I get all the way to the black screen, after which I am
supposed to see the writing pages to disk message.
Instead I see an error message flashing by to fast to read and
everything wakes up, although only part way.
I can switch consoles, but the keyboard doesn't type anything to screen,
and if I switch to X everything locks up.
If I suspend with less applications running, everything works fine.
A sufficient load to cause the problem is running X (with gnome),
evolution, matlab and gnome-multi-terminal.
Could find any error logs under /var/log.
Under 2.4 and the swsusp patch the kernel does suspend with those
problems.
Any idea how to proceed in locating the problem?

-- 
Micha Feigin
michf@math.tau.ac.il

