Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266913AbUFZDjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266913AbUFZDjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 23:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266930AbUFZDjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 23:39:48 -0400
Received: from avas-mr06.fibertel.com.ar ([24.232.0.219]:35754 "EHLO
	avas-mr06.fibertel.com.ar") by vger.kernel.org with ESMTP
	id S266913AbUFZDjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 23:39:47 -0400
X-Comment: RFC 2476 MSA function at avas-mr06.fibertel.com.ar logged sender identity as: jcarminati
Message-ID: <40DCEFFB.5020605@fibertel.com.ar>
Date: Sat, 26 Jun 2004 00:39:39 -0300
From: limaunion <limaunion@fibertel.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm2 build errors...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Fib-Al-Info: Al
X-Fib-Al-MRId: 2527d8cb9d1fbd0e0679aab72d53fe1d
X-Fib-Al-From: limaunion@fibertel.com.ar
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0xbe14): In function `powernow_acpi_init':
: undefined reference to `acpi_processor_register_performance'
arch/i386/kernel/built-in.o(.text+0xbe3b): In function `powernow_acpi_init':
: undefined reference to `acpi_processor_unregister_performance'
arch/i386/kernel/built-in.o(.exit.text+0x3b): In function `powernow_exit':
: undefined reference to `acpi_processor_unregister_performance'
make: *** [.tmp_vmlinux1] Error 1

This also happens in 2.6.7-mm1, I'm wondering if this is my fault or 
something's wrong?

Thanks in advance!
JC

PS: Please CC me for any answer.
