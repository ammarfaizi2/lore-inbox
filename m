Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbULZGcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbULZGcG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 01:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbULZGcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 01:32:06 -0500
Received: from pils.linux-kernel.at ([62.116.87.200]:12679 "EHLO
	pils.linux-kernel.at") by vger.kernel.org with ESMTP
	id S261623AbULZGcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 01:32:01 -0500
Message-Id: <200412260631.iBQ6VZTk027678@pils.linux-kernel.at>
From: "Oliver Falk" <oliver@linux-kernel.at>
To: <linux-kernel@vger.kernel.org>
Subject: Dhcp: Ip length 44 disagrees with bytes received 46.
Date: Sun, 26 Dec 2004 07:31:14 +0100
Organization: linux-kernel.at
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcTrFH+r2BAjutgjRh6Heu9OunzS2g==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-lkernAT-MailScanner-Information: Please contact the ISP for more information
X-lkernAT-MailScanner: Found to be clean
X-lkernAT-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.746,
	required 5, AWL -2.47, BAYES_50 0.00, MSGID_FROM_MTA_ID 1.72)
X-MailScanner-From: oliver@linux-kernel.at
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkml!

Maybe it's not good to ask the lkml, but since there are so many experts
here, it makes sense to me.

I have a dhcp-server running with 2.6.10 (had it running with
2.6.{1,2,3,4,5,6,7,8,9} as well) and the dhcpd logs all the time:

<snip>
Dec 26 07:22:11 brain dhcpd: ip length 44 disagrees with bytes received 46.
Dec 26 07:22:11 brain dhcpd: accepting packet with data after udp payload.
Dec 26 07:22:11 brain dhcpd: ip length 44 disagrees with bytes received 46.
Dec 26 07:22:11 brain dhcpd: accepting packet with data after udp payload.
Dec 26 07:22:51 brain dhcpd: ip length 44 disagrees with bytes received 46.
Dec 26 07:22:51 brain dhcpd: accepting packet with data after udp payload.
Dec 26 07:22:51 brain dhcpd: ip length 44 disagrees with bytes received 46.
Dec 26 07:22:51 brain dhcpd: accepting packet with data after udp payload.
Dec 26 07:23:11 brain dhcpd: ip length 44 disagrees with bytes received 46.
Dec 26 07:23:11 brain dhcpd: accepting packet with data after udp payload.
Dec 26 07:23:11 brain dhcpd: ip length 44 disagrees with bytes received 46.
Dec 26 07:23:11 brain dhcpd: accepting packet with data after udp payload.
</snip>

Now my question; Is this normal? Where does it come from? Why does it
happen? For me this seems strange...

FYI. I have the server running with the above mentioned kernel and Fedora
Core Development Tree (dhcpd 3.0.1).

Any help is welcome!

Best regards,
 Oliver

