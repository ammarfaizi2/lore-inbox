Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWFXPmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWFXPmR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWFXPmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:42:17 -0400
Received: from smtp-out.google.com ([216.239.45.12]:29942 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750842AbWFXPmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:42:16 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=RkmrezLLQ2Y4C8sfBhxXmSneSPTVGHpLQDc9ag4KqDzr4emhAPgLFyu+glndI/FtN
	kdqS8qe5vh6C41jkL0c/Q==
Message-ID: <449D5D36.3040102@google.com>
Date: Sat, 24 Jun 2006 08:41:42 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm2 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panic on PPC64. I'm guessing it's the same as the i386 panics I sent
you yesterday, just more cryptic ;-) But for the record ...

http://test.kernel.org/abat/37737/debug/console.log

cpu 0x2: Vector: 300 (Data Access) at [c0000000f99f78c0]
     pc: c0000000000c6a34: .s_show+0x178/0x364
     lr: c0000000000c696c: .s_show+0xb0/0x364
     sp: c0000000f99f7b40
    msr: 8000000000001032
    dar: fd528000
  dsisr: 40000000
   current = 0xc0000000f23e0000
   paca    = 0xc00000000046e300
     pid   = 17653, comm = cp
enter ? for help
