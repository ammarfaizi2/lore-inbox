Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270222AbTGML3k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 07:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270223AbTGML3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 07:29:40 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:38065 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270222AbTGML3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 07:29:40 -0400
Date: Sun, 13 Jul 2003 13:44:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.75: problems with qtopia-embedded
Message-ID: <20030713114413.GA388@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There's something wrong with qvfb/qtopia applications under 2.5.75 (I
have not tried any other 2.5 version, works okay in 2.4.X).

I got this in syslog after experiments finished. (qvfb segfaulted).

Jul 13 07:24:00 amd kernel: Unable to handle kernel paging request at virtual address 40ae7706
Jul 13 07:24:00 amd kernel:  printing eip:
Jul 13 07:24:00 amd kernel: 40ae7706
Jul 13 07:24:00 amd kernel: *pde = 082dd067
Jul 13 07:24:00 amd kernel: *pte = 00000000
Jul 13 07:24:00 amd kernel: Oops: 0004 [#1]
Jul 13 07:24:00 amd kernel: CPU:    0

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
