Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUFOU2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUFOU2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUFOU2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:28:12 -0400
Received: from centaur.culm.net ([83.16.203.166]:16145 "EHLO centaur.culm.net")
	by vger.kernel.org with ESMTP id S265909AbUFOU2J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:28:09 -0400
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7] [OOPS] Oops while removing mediabay CD
Date: Tue, 15 Jun 2004 22:26:07 +0200
User-Agent: KMail/1.6.2
References: <200406152210.13537.adasi@kernel.pl>
In-Reply-To: <200406152210.13537.adasi@kernel.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406152226.07331.adasi@kernel.pl>
X-Spam-Score: -4.6 (----)
X-MIME-Warning: Serious MIME defect detected ()
X-Scan-Signature: 58444daecd5819ce53022823bc23d18d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia wtorek 15 czerwiec 2004 22:10, napisa³e¶:
Well, I forgot to add decoded oops:
Call trace: [c000b244]  [c009b9d8]  [c0117594]  [c0312800]  [c031294c]
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0097D04 LR: C0098EB0 SP: C1893E50 REGS: c1893da0 TRAP: 0300    Not
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cbe0ad20[156] 'media-bay' THREAD: c1892000Last syscall: -1
GPR00: C0098EB0 C1893E50 CBE0AD20 00000000 C03418D0 C18AC310 00000000
00000000
GPR08: 00000001 FFFF0001 C0336384 00009032 FFFFFFFA 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00220000 00230000
C0280000
GPR24: C9C86800 00000001 CBFEE294 00000000 00000001 C0341C40 00000000
C03418D0
Call trace: [c0098eb0]  [c00fc56c]  [c00fc764]  [c00fb134]  [c00fb1b8]
Warning (Oops_read): Code line not seen, dumping what data is available


>>NIP; c0097d04 <sysfs_hash_and_remove+18/dc>   <=====

>>GPR0; c0098eb0 <sysfs_remove_link+14/24>
>>GPR4; c03418d0 <macio_lock+7c8/3040>
>>GPR10; c0336384 <per_cpu__rcu_data+c/1c>
>>GPR29; c0341c40 <macio_lock+b38/3040>
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
