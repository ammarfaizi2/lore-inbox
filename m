Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264066AbUDVONp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUDVONp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 10:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbUDVONp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 10:13:45 -0400
Received: from dsl081-101-153.den1.dsl.speakeasy.net ([64.81.101.153]:695 "EHLO
	mail.chen-becker.org") by vger.kernel.org with ESMTP
	id S264066AbUDVONl (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 10:13:41 -0400
Message-ID: <4087D311.5080302@chen-becker.org>
Date: Thu, 22 Apr 2004 08:13:37 -0600
From: Derek Chen-Becker <derek@chen-becker.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel@vger.kernel.org
Subject: Problem with 2.6.3 and initrd
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     I've been trying all day to get 2.6.3 booting on my server from 
2.4.22. I've run into a major issue with the initrd, and I can't figure 
out what's going on. The kernel finds the initrd and mounts it on root, 
but then the first command I have (mount /proc) fails with an error that 
it can't create a lock on mtab because there is no space left on the 
device. Everything else after that blows up. I thought I'd be clever and 
create a bogus file on the initrd, then delete it as the first step in 
linuxrc so that there is space on the device, but I still get the same 
error. My 2.4.22 kernel works find with a very similar initrd, so I'm 
having trouble figuring out what is different here. I've done all kinds 
of google searches on this and haven't found anything very helpful other 
than some references to initramfs. Any thoughts?

Thanks,

Derek

-- 
+---------------------------------------------------------------+
| Derek Chen-Becker                                             |
| derek@chen-becker.org                                         |
| http://chen-becker.org                                        |
|                                                               |
| PGP key available on request or from public key servers       |
| ID: 21A7FB53                                                  |
| Fngrprnt: 209A 77CA A4F9 E716 E20C  6348 B657 77EC 21A7 FB53  |
+---------------------------------------------------------------+
