Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVLOWuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVLOWuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLOWuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:50:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:21467 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751179AbVLOWus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:50:48 -0500
Date: Thu, 15 Dec 2005 23:50:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Arjan van de Ven <arjan@infradead.org>,
       Gaurav Dhiman <gaurav4lkg@gmail.com>, yen <yen@eos.cs.nthu.edu.tw>,
       linux-kernel@vger.kernel.org
Subject: Re: IRQ vector assignment for system call exception
In-Reply-To: <20051211105844.GA4085@elte.hu>
Message-ID: <Pine.LNX.4.61.0512152349580.13568@yvahk01.tjqt.qr>
References: <20051208080435.M54890@eos.cs.nthu.edu.tw>
 <1e33f5710512100520k57c016b0tadfbb496cac3ea6e@mail.gmail.com>
 <1134238271.2828.19.camel@laptopd505.fenrus.org> <20051211105844.GA4085@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Sat, 2005-12-10 at 18:50 +0530, Gaurav Dhiman wrote:
>> > yes, definetely a historical reason. System libraries need to know
>> > this vector to invoke system call.
>> 
>> nowadays it's also mostly unused; sysenter and friends are used 
>> instead and they don't use this entry point.
>
>note that some system-calls are still invoked via int80 by glibc, such 
>as fork() - even on sysenter/syscall capable CPUs.

OT: Any idea when glibc moves to use sysenter on capable CPUs?



Jan Engelhardt
-- 
