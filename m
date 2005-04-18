Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVDRBgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVDRBgp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 21:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVDRBgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 21:36:44 -0400
Received: from mail.avantwave.com ([210.17.210.210]:47574 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261581AbVDRBgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 21:36:43 -0400
Message-ID: <42630F26.3060503@haha.com>
Date: Mon, 18 Apr 2005 09:36:38 +0800
From: Tomko <tomko@haha.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question : is the init process of kernel running in kernel space
 or user space?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In the linux system , kernel is often starting up like this :

bootloader -> start_32() -> start_kernel() -> init()

i would like to ask what is the piority level in this starting procedure 
? 0 or 3 ? that means, this start up process are running in kernel space 
or user space ?  or the level is keep changing ?
If it is in kernel space from the very beginning , at which point the 
system is switched into user space ? is it at the time when kernel open 
the shell ?

I am new to linux, hope someone can help me here.


Regards,
TOM
