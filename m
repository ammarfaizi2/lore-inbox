Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWHBVag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWHBVag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWHBVag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:30:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:42970 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932198AbWHBVaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:30:35 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [patch] x86: rename is_at_popf(), add iret to tests and fix insn length
To: Andi Kleen <ak@suse.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Wed, 02 Aug 2006 23:29:30 +0200
References: <6FokL-6q5-7@gated-at.bofh.it> <6Fouu-6Ch-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G8OHm-0000m3-91@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
> On Wednesday 02 August 2006 14:37, Chuck Ebbert wrote:

>> is_at_popf() needs to test for the iret instruction as well as
>> popf.  So add that test and rename it to is_setting_trap_flag().
> 
> Do you have a single real example where anybody is actually using IRET
> in user space?

It might be used by malicious software, so unless it can't be abused,
it must be checked.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
