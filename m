Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTJRFmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 01:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTJRFmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 01:42:21 -0400
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:44458 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S261321AbTJRFmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 01:42:20 -0400
Message-ID: <XFMail.20031018014148.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20031018052609.GH25291@holomorphy.com>
Date: Sat, 18 Oct 2003 01:41:48 -0400 (EDT)
From: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8: broken  /fs/proc/array.c  compilation
Cc: William Lee Irwin III <wli@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18-Oct-2003 William Lee Irwin III wrote:
> On Sat, Oct 18, 2003 at 01:18:26AM -0400, Duncan Haldane wrote:
>> fs/proc/array.c: In function `proc_pid_stat':
>> fs/proc/array.c:398: Unrecognizable insn:
>> (insn/i 1332 1672 1666 (parallel[
>>             (set (reg:SI 0 eax)
>>                 (asm_operands ("") ("=a") 0[
>>                         (reg:DI 1 edx)
>>                     ]
> 
> Compiler bogon, not kernel.

OK, This is the Red Hat 7.3 version of "gcc-2.96-113", which
is "special" (RedHat-patched).  It's reacting to the changes in 2.6.0-test8. 
Does this mean that this compiler has now become unusable for 2.6.0 > test7
with /proc support?

Duncan

