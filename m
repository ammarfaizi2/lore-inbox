Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268581AbRG3NDq>; Mon, 30 Jul 2001 09:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268582AbRG3NDf>; Mon, 30 Jul 2001 09:03:35 -0400
Received: from [195.66.192.167] ([195.66.192.167]:44299 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S268581AbRG3NDP>; Mon, 30 Jul 2001 09:03:15 -0400
Date: Mon, 30 Jul 2001 16:05:27 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <10993682989.20010730160527@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Default log level
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I have syslogd configured to dump everything on tty12
and warnings and up on tty11

Well, I wonder, why there's so much warnings out there?
Most messages I see on tty11 are purely informative.
>From kernel/printk.c I learned that KERN_WARNING
is default log level. I think most developers use explicit
KERN_WARNING when they want to warn user.

What about switching default log level to KERN_NOTICE?

Please CC me. I'm not on the list. Really! :-)
-- 
Best regards,
VDA                          mailto:VDA@port.imtp.ilyichevsk.odessa.ua


