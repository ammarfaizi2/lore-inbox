Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWCWJrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWCWJrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWCWJrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:47:22 -0500
Received: from smtpauth01.csee.siteprotect.com ([64.41.126.132]:42158 "EHLO
	smtpauth01.csee.siteprotect.com") by vger.kernel.org with ESMTP
	id S1750787AbWCWJrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:47:21 -0500
From: "Yogesh Pahilwan" <pahilwan.yogesh@spsoftindia.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-raid@vger.kernel.org>
Subject: raw I/O support for Fedora Core 4
Date: Thu, 23 Mar 2006 14:54:25 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
thread-index: AcZOW5OW41hvxUiETlCxYZ47H+q2jA==
Message-ID: <WM57DB3DF98115400697C908A54A80DEE9@spsoftindia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I want to do raw I/O on MD RAID and LVM for fedora core 4(kernel 2.6.15.6).

After doing googling I came to know that "raw" command does the raw
operation by linking 
MD device and LVM volume to the raw device as 

# raw /dev/raw/raw1 /dev/md0.

But when I search on this I came to know that there is no raw (/dev/rawctl)
device support available with 2.6 kernel.
I have also tried recompile the kernel sources with raw device support it is
not getting compiled as it is obsolete in 2.6. 
If I want to include raw device support in my kernel what should I will have
to do, so that I 
Will be able to do raw I/O on MD device and LVM volumes.

Thanks and Regards,
Yogesh

