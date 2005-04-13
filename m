Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVDMEZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVDMEZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVDMEWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 00:22:48 -0400
Received: from mail.avantwave.com ([210.17.210.210]:20648 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S262208AbVDMEVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 00:21:54 -0400
Message-ID: <425C9E55.6010607@haha.com>
Date: Wed, 13 Apr 2005 12:21:41 +0800
From: Tomko <tomko@haha.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why system call need to copy the date from the userspace before using
 it
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am new to linux , hope someone can help me.
While i am reading the source code of the linux system call , i find 
that the system call need to call copy_from_user() to copy the data from 
user space to kernel space before using it . Why not use it directly as 
the system call has got the address ?  Furthermore , how to distinguish 
between user space and kernel space ?

Thx a lot,

TOM
