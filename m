Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291284AbSBMBhZ>; Tue, 12 Feb 2002 20:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291289AbSBMBhS>; Tue, 12 Feb 2002 20:37:18 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:26045 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291284AbSBMBhJ>; Tue, 12 Feb 2002 20:37:09 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: What is a livelock? (was: [patch] sys_sync livelock fix)
In-Reply-To: <3C69A18A.501BAD42@zip.com.au>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Wed, 13 Feb 2002 02:36:45 +0100
In-Reply-To: <3C69A18A.501BAD42@zip.com.au> (Andrew Morton's message of
 "Tue, 12 Feb 2002 15:13:14 -0800")
Message-ID: <87y9hyw4b6.fsf@tigram.bogus.local>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> The get_request fairness patch exposed a livelock
> in the buffer layer.  write_unlocked_buffers() will
> not terminate while other tasks are generating write traffic.

The subject says it: what is a livelock? How is it different 
from a deadlock?

Thanks, Olaf.
