Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278320AbRJMQEH>; Sat, 13 Oct 2001 12:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278321AbRJMQD5>; Sat, 13 Oct 2001 12:03:57 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:61963 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S278320AbRJMQDt>;
	Sat, 13 Oct 2001 12:03:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: cpus_allowed
Date: Sat, 13 Oct 2001 16:59:40 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01101316594000.02369@home01>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was curious about "CPU affinity" in linux. I found some patches which add 
affinity in task_struct but later I found out that "cpus_allowed" in 
task_struct almost does the same thing.

It resulted in some new curiosity: where's cpus_allowed initialized? I can 
only find an assignment to cpus_allowed for softirq's but no initialization 
for other processes. I assume the correct init value would be "0xffffffff" or 
-1. Can't find it though.

I'm sure I'm overlooking something, but that doesn't help me finding the 
answer. So would someone be so kind to enlighten me?

Thanks,

Rolf
