Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131129AbQKJUWl>; Fri, 10 Nov 2000 15:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131557AbQKJUWc>; Fri, 10 Nov 2000 15:22:32 -0500
Received: from web1106.mail.yahoo.com ([128.11.23.126]:55821 "HELO
	web1106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130369AbQKJUWX>; Fri, 10 Nov 2000 15:22:23 -0500
Message-ID: <20001110202221.29946.qmail@web1106.mail.yahoo.com>
Date: Fri, 10 Nov 2000 21:22:21 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dick, have you tried a simple "strace -f -p <pid>" ?
This often gives enough info.

BTW, there's one version of sendmail that tests the
capability security hole of a previous kernel version
(2.2.15 ?), and refuses to launch if it discovers it.
It may be possible that sendmail does other tests like
this one.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
