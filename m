Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVALWlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVALWlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVALWln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:41:43 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:16865 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261524AbVALWjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:39:09 -0500
Message-ID: <41E5A70B.30807@us.ibm.com>
Date: Wed, 12 Jan 2005 16:39:07 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kobject uevent/netlink question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to modify an existing application I wrote to make use of 
kobject uevents instead of polling. Is there a good way for a user space 
  application to determine if kobject uevent support exists on the 
system it is running on? I'd like to be able to detect at runtime 
whether or not I can use uevent or if I need to revert to polling mode.

Thanks

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
