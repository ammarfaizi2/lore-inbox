Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTLHWCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 17:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTLHWCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 17:02:41 -0500
Received: from varis.cs.tut.fi ([130.230.4.42]:38289 "EHLO cs.tut.fi")
	by vger.kernel.org with ESMTP id S261892AbTLHWCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 17:02:37 -0500
Message-ID: <001b01c3bdd6$ed8a2310$1b32e682@dmi.tut.fi>
Reply-To: "Aurelian Pop" <aurelian.pop@ondems.com>
From: "Aurelian Pop" <aurelian.pop@ondems.com>
To: <linux-kernel@vger.kernel.org>
Subject: Menuconfig problem
Date: Tue, 9 Dec 2003 00:02:09 +0200
Organization: =?iso-8859-1?Q?Ond=E9ms_Ltd.?=
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I was trying to recomile my kernel and when configuring it I got the next
message:

Quote:
********


Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu78: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1


********
End quote.


Therefore, I'm reporting you that the kernel version is: linux-2.4.22-10mdk

The "uname -a" command returns:
"Linux core.ondems.com 2.4.22-10mdk #1 Thu Sep 18 12:30:58 CEST 2003 i686
unknown unknown GNU/Linux"

The menu I was trying to get into (when this error appeared) was the "Advanced
Linux Sound Architecture".

If it helps, before I was trying to enter into that submenu I removed the
support for *all* the sound cards in the "Sound" menu.


Hoping that it helps,

Best regards
Aurelian

--------
Aurelian Pop


ONDÉMS Ltd.
P.O. Box 19, 33721 Tampere, Finland
+358 40 0690345
http://www.ondems.com




