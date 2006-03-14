Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWCNUy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWCNUy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWCNUy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:54:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52447 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932070AbWCNUy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:54:28 -0500
To: "Mauricio Lin" <mauriciolin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Jiffy is not able to measure the fraction of time a process runs a processor
References: <3f250c710603130549w6ccdf14cu73a0d7d2999fd4ee@mail.gmail.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 14 Mar 2006 15:54:17 -0500
In-Reply-To: <3f250c710603130549w6ccdf14cu73a0d7d2999fd4ee@mail.gmail.com>
Message-ID: <y0mveugagsm.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mauricio Lin" <mauriciolin@gmail.com> writes:

>  I am trying to measure the fraction of time a process runs on a
> processor, but the jiffies is not able to provide an accurate value.

See sched_clock().

>  The example below [...]
> PID  : NAME : LAST ARRIVAL : CPU TIME : CALLER
> 4544 : kmix : 6170433 : 0 : work_resched+0x6c
> 4078 : lpd : 6170433 : 0 : __down_interruptible+0x5
> 4544 : kmix : 6170433 : 0 : schedule_timeout+0xb8

What tool/patchset are you using to generate this trace?


- FChE
