Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRAHXVc>; Mon, 8 Jan 2001 18:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131901AbRAHXVW>; Mon, 8 Jan 2001 18:21:22 -0500
Received: from oldftp.webmaster.com ([209.10.218.74]:52634 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S130516AbRAHXVF>; Mon, 8 Jan 2001 18:21:05 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <Steven_Snyder@3com.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Shared memory not enabled in 2.4.0?
Date: Mon, 8 Jan 2001 15:21:03 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKKECDMOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <882569CE.0069993A.00@hqoutbound.ops.3com.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For some reason shared memory is not being enabled on my system
> running kernel
> v2.4.0 (on RedHat v6.2,  with all updates applied).

	You are confusing System V shared memory (IPC) with VM shared memory. The
'0' for shared in /proc/meminfo means the system can't easily tell you how
much memory the VM is sharing. But this has nothing whatsoever to do with
IPC shared memory, which is what the /dev/shm thing is about.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
