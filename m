Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269373AbRGaRcM>; Tue, 31 Jul 2001 13:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269376AbRGaRcB>; Tue, 31 Jul 2001 13:32:01 -0400
Received: from shared1-batch.whowhere.com ([209.185.123.82]:55448 "HELO
	shared1-mail.whowhere.com") by vger.kernel.org with SMTP
	id <S269373AbRGaRbt>; Tue, 31 Jul 2001 13:31:49 -0400
To: linux-kernel@vger.kernel.org
Date: Tue, 31 Jul 2001 23:31:39 +0600
From: "Tango Tiger" <klistener@eudoramail.com>
Message-ID: <KCGIPDEGAOALKAAA@shared1-mail.whowhere.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: klistener@eudoramail.com
X-Mailer: MailCity Service
Subject: Somewhat bizzare network/kernel problem
X-Sender-Ip: 208.162.178.1
Organization: QUALCOMM Eudora Web-Mail  (http://www.eudoramail.com:80) 
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Since upgrading to kernel 2.4.5+ I have been having problems transferring files
over the network. After a seemingly random number of bytes (normally a few 100k)
the operation seems to hang. This occurs regardless of transfer mechanism
(I've tried scp,ftp and smb).  This leads me to conclude that it is a kernel/driver 
issue.  Using smb it hangs such that the mount point will not unmount (at all - reboot
required) and the mount becomes unusable, with any access hanging.

The network driver I use is tulip, and this problem occurs if I use the either
development version of the tulip driver or the version shipped with the kernel.
NICs in use are Linksys EtherFast (mostly) and one Cnet card.

This did not occur using 2.2.x.

I am unsure as to what would help with diagnostics - but this is _very_ easy to 
reproduce so I'll be glad to help in any way.

Thank you.

David.





Join 18 million Eudora users by signing up for a free Eudora Web-Mail account at http://www.eudoramail.com
