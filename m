Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVEPKI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVEPKI2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 06:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVEPKI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 06:08:28 -0400
Received: from champagne.comp.nus.edu.sg ([137.132.80.90]:62214 "EHLO
	champagne.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id S261543AbVEPKI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 06:08:26 -0400
Message-ID: <42887147.9000302@pobox.com>
Date: Mon, 16 May 2005 18:09:11 +0800
From: Lai Zit Seng <lzs@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: pivot_root()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure where to post this, forgive me if there is a better place to 
post...

I'm trying to use pivot_root() to change root to a directory that is not 
a mount point, i.e. it is under a mount point of a different device from 
the current root device.

E.g.

# /root is mounted from /dev/sda1
pivot_root("/root/somewhere", "/root/somewhere/initrd");

But pivot_root() returns EINVAL. Both /root/somewhere and 
/root/somewhere/initrd exists.

Any pointers about what might be wrong? Many thanks :)

Regards,

.lzs
