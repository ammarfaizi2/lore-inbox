Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWAGJ7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWAGJ7P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 04:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWAGJ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 04:59:15 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:20635 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932709AbWAGJ7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 04:59:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=SeSw0BwksnKHSZjjvZy8NTXpjGGENkXpJ6PsqznNz143+tmyMoTt6AQU0DMd/sl+LS9HI0syUuAM0w38kncfH7NMxC3EVCb2vEh95+GXhen6QlZwAMsGguc5a0gtpu7+DfwoepF2sJ4esMURx1PXEwwE7BDTfY6dFc5Q8aUlU+k=
Message-ID: <43BF9114.7040102@gmail.com>
Date: Sat, 07 Jan 2006 14:59:48 +0500
From: "Alexander E. Patrakov" <patrakov@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: sanitized kernel headers
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

almost two years ago, a decision has been made that raw kernel headers 
are for the kernel only, and that userspace should be built against some 
"sanitized" kernels. Linux-Libc-Headers 
(http://ep09.pld-linux.org/~mmazur/linux-libc-headers/) were one of the 
implementations of such sanitized headers, and they worked well and were 
used e.g. in Linux From Scratch.

But now, the Linux-Libc-Headers project looks dead: no commits in the 
SVN for the last two months, and the only changes in SVN as compared to 
LLH 2.6.12.0 are addition of inotify.h, removal of some kernel-only 
headers and some minor fix for non-glibc systems.

What is the recommended (non-dead) alternative implementation of such 
"sanitized" headers? Where is the roadmap for this area?

-- 
Alexander E. Patrakov
Don't mail to patrakov@ums.usu.ru: the server is off until 2006-01-11
Use my GMail or linuxfromscratch address instead

