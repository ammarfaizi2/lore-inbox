Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUGIQHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUGIQHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 12:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265033AbUGIQHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 12:07:08 -0400
Received: from imap.gmx.net ([213.165.64.20]:58785 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265030AbUGIQHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 12:07:07 -0400
X-Authenticated: #1487108
Message-ID: <40EEC23B.4090301@gmx.de>
Date: Fri, 09 Jul 2004 18:05:15 +0200
From: Ulrich Brand <ulrich.brand@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel org <linux-kernel@vger.kernel.org>
Subject: kswappd problem - additional facts
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there are 2 little errors in my last posting - sorry.
the #include "shmem.h" is obsolate.
additionally, you have to increase yous shared memory limit
on standard installations:
echo 2500000000 > /proc/sys/kernel/shmmax
echo 2500000000 > /proc/sys/kernel/shmall
- my shell command to start the processes has a wrong char.
for ((i=1;i<200;i++)); do ./shm 1000 30 1234 0 & sleep 1; done

ulrich
