Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbTGJKTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269174AbTGJKTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:19:06 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:46349 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S269173AbTGJKTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:19:01 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: jamie@shareable.org
Subject: NFS client errors with 2.5.74?
Date: Thu, 10 Jul 2003 18:30:59 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307101830.59669.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I chewed on that a while ago and was advised not to use "soft" mounts.

My 2.4<>2.4 setup worked with "soft" for ages, but it broke when
running 2.5.6x/7x on the server.

If you are using soft mounts, use "hard,intr" instead. 

Regards
Michael

-- 
Powered by linux-2.5.74-mm3. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

