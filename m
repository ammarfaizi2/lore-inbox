Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTLCUag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTLCUag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:30:36 -0500
Received: from stinkfoot.org ([65.75.25.34]:38279 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S261309AbTLCUaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:30:35 -0500
Message-ID: <3FCE47D2.1010102@stinkfoot.org>
Date: Wed, 03 Dec 2003 15:30:10 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: HT apparently not detected properly on 2.4.23
References: <3FCE2F8E.90104@stinkfoot.org> <1070480450.15415.85.camel@slurv.pasop.tomt.net> <20031203195631.GC29119@mis-mike-wstn.matchmail.com>
In-Reply-To: <20031203195631.GC29119@mis-mike-wstn.matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

> Depending on the logical addressing of your processors, CONFIG_NR_CPUS=8 may
> work in this case too.
> 
> Some processors/motherboards logically address the CPUs other that 0-3 if
> there are 4 processors.
> 
> Currently CONFIG_NR_CPUS needs to be big enough to hold the largest logical
> processor number.

Thanks.  This rings a bell, I seem to remember what I thought to be
"impossible numbering" on the CPUs such as "CPU7" or somesuch in a
dmesg.. Will have to look through logs.  I'll raise CONFIG_NR_CPUS and
see what I get.  Now, the question is, why do we only interrupt on CPU0
on this pasrticular box|chipset with a vanilla kernel? ACPI problem?  My
SMP G4 ppc has an option in menuconfig: "distribute interrupts on all
CPUs by default", the x86 has no such option.

Ethan


