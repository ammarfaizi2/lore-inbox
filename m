Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTJYINL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 04:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTJYINL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 04:13:11 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:47354 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S262409AbTJYINI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 04:13:08 -0400
Date: Sat, 25 Oct 2003 21:12:54 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Announce: Swsusp-2.0-2.6-alpha1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1067069558.1975.54.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I'm pleased to be able to announce the first test release of a port of
the current 2.0 pre-release Software Suspend code to 2.6. This is now
available from www.sourceforge.net/projects/swsusp and
bk://swsusp25.bkbits.net/main.

Release notes:
- The patch is prepared against current bk. It should apply against
test8 with minimal and perhaps no fuss.
- Breaks current Software Suspend implementations in the kernel.
Apologies to Patrick and Pavel. I won't be leaving it this way for long,
I promise!
- I/O is slow and jerky. I need to investigate the cause for this
further; something in the hooks to the new bio code is not quite right.

Apart from the above, and the normal problems with incomplete driver
support will continue. In addition, you may see freezing failures. If
the process hangs at 'Freezing processes: Waiting for activity to
finish' or 'Syncing remaining I/O', try pressing escape once. If the
process doesn't abort, try a second time (which tries harder to restart
things). All going well, you should be able to cancel the suspend. A log
of what went wrong will be stored in /var/log/messages. Run it through
ksymoops if necessary and send it to me, and I should be able to address
the issue.

Please send feedback via the Software Suspend mailing list on
Sourceforge. See http://swsusp.sf.net for FAQs, mailing list details and
so on. Because the code is essentially the same as the 2.4 version, many
of the solutions to issues will be the same.

As always, I look forward to hearing feedback.

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

