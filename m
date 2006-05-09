Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWEIHX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWEIHX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWEIHX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:23:58 -0400
Received: from [210.76.108.236] ([210.76.108.236]:63682 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751445AbWEIHX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:23:57 -0400
Message-ID: <44604395.9070909@ccoss.com.cn>
Date: Tue, 09 May 2006 15:24:05 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Question] How access standard PC io port?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

    I have one question about standard PC(i386) resource (io port).
   
    I found we register these resource here:
    
        http://lxr.linux.no/source/arch/i386/kernel/setup.c#L1185
   
    I want to read/write some data from PS/2 keyboard controller buffer
(IOW, from io port 0x60), and I guest that the buffer may corrupt in SMP
envionment if we access them without something like lock protect,
but I can not find any information or code related.
   
    Which great guru would like help me a little bit?
   
    Thanks in advanced.

-liyu
