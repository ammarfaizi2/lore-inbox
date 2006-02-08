Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWBHVdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWBHVdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBHVdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:33:19 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:26595 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750765AbWBHVdT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:33:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UAk02FZOxTcXzk7uscrJCnnY3reCV4QDywZ8TlxW4Vmoih1/zMKXKQUobkYojaay1OjKB3P9aySpN1EQPm9L6dnRc0YKAYndEcX9HSCzAbRRrddHaukWes9rkrE3AkK3MPxGTq1qa1JU2BFEPMFfUWz8fy8ctFD+JLPZJ9kSgng=
Message-ID: <2753bafa0602081333y2f0f8c37o210b8acb6b3b73d1@mail.gmail.com>
Date: Wed, 8 Feb 2006 22:33:17 +0100
From: thomas <thomas.bsd@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Incomprehensible Boot freeze & Crash - Kernel 2.6.12
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm running Debian GNU/Linux Etch on an Acer Aspire 1682 laptop with
kernel 2.6.12-1-686. So far the system was rock solid but I'm now
experiencing a boot freeze:

... Setting up ICE socket directory /tmp/ICE-Unix... done
INIT: Entering runlevel: 2
Starting system log daemon: syslogd

Then, nothing. However I can boot in "recover mode" (that is, single
user & root login). There does not seem to be any hardware failure,
the partitions are properly mounted, and there is engough free space
on any of them. When I shut down the box, hundreds of lines of errors
messages are outputted. I cannot read them all but here are the last
ones:

EIP is at do_page_fault+0xd6/0x6bf
eax: dfa40000 ebx:00000000 ecx:0000007b edx:ffffff7b esi:00030001
edi:0000000d ebp:0000000b esp: dfa417c8
ds: 007b es:007b ss:0008
Unable to handle kernel paging request at virtual address ffffffef
printing eip:
c0114fe6
*pde=00002067
*pte=00000000
Recursive die() failure, output suppressed
 <0> Kernel panic - not syncing: Fatal exception in interrupt
_

The last time Linux could boot properly, I did not perform any task at
root: I did not install any hardware, nor I modified any config file.
I did not change anything in the BIOS either.

I have tried to boot with special options (noapic, nolapic, pci=off,
pnpbios=off) without success.

I can show any file on my system if needed.

Thanks in advance for your help. I have absolutely no idea of what I
can do; without your help I can go nowhere.

Best regards,
Thomas
