Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWBEUZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWBEUZf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 15:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWBEUZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 15:25:35 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:15844 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750710AbWBEUZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 15:25:35 -0500
Message-ID: <43E65F51.7040103@yahoo.fr>
Date: Sun, 05 Feb 2006 21:25:53 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hyphen in module names
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The fact that '-' is replaced by '_' in module names seems
to be a feature not a bug. So, what was the rationale for this?

A drawback is that it becomes not trivial to map module
names to filenames as this does not work:
for FILE in $(cut -d' ' -f1 < /proc/modules); do
    ls /lib/modules/MY_NEW_KERNEL/kernel/**/$FILE.ko
done

If it is some kind of user-friendliness, then why not make
the module name matching case insensitive ?  :-p

Sorry for the ranting tone, but I am quite confused.

Thanks.

-- 
Guillaume

