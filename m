Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268369AbTAMWGP>; Mon, 13 Jan 2003 17:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268370AbTAMWGP>; Mon, 13 Jan 2003 17:06:15 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:52744 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268369AbTAMWGN>;
	Mon, 13 Jan 2003 17:06:13 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jens Axboe <axboe@suse.de>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*? 
In-reply-to: Your message of "Mon, 13 Jan 2003 19:48:31 BST."
             <20030113184831.GC14017@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Jan 2003 09:14:52 +1100
Message-ID: <7857.1042496092@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003 19:48:31 +0100, 
Jens Axboe <axboe@suse.de> wrote:
>On Mon, Jan 13 2003, Zwane Mwaikambo wrote:
>> It uses NMI's to break into the debugger, so it would also work with 
>> interrupts disabled and spinning on a lock, the same is also true for 
>> kgdb.
>
>But still requiring up-apic, or smp with apic, right?

nmi_watchdog=2 - uses performance counters, not apic.

