Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUF3Ksy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUF3Ksy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 06:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266579AbUF3Ksy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 06:48:54 -0400
Received: from mail1.kontent.de ([81.88.34.36]:12198 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265970AbUF3Ksx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 06:48:53 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Subject: Re: Preemption of the OS system call due to expiration of the time-sl ice for: a) SCHED_NORMAL (aka SCHED_OTHER) b) SCHED_RR
Date: Wed, 30 Jun 2004 12:50:04 +0200
User-Agent: KMail/1.6.2
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'andrebalsa@altern.org'" <andrebalsa@altern.org>,
       "'Richard E. Gooch'" <rgooch@atnf.csiro.au>,
       "'Ingo Molnar'" <mingo@elte.hu>, "'rml@tech9.net'" <rml@tech9.net>,
       "'akpm@osdl.org'" <akpm@osdl.org>, "'Con Kolivas'" <kernel@kolivas.org>
References: <313680C9A886D511A06000204840E1CF08F42FAE@whq-msgusr-02.pit.comms.marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF08F42FAE@whq-msgusr-02.pit.comms.marconi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406301250.04473.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 30. Juni 2004 11:50 schrieb Povolotsky, Alexander:
> Con - thanks for your kind answers !
> 
> Preemption (due to the expiration of the time-slice) of the process, while
> it executes OS system call, -  by another process (of equal or higher
> priority) when running under following scheduling policies:
> 
>  a) SCHED_NORMAL (aka SCHED_OTHER)
>  b) SCHED_RR 
> 
> Is it possible in Linux 2.6 ? Linux 2.4 ?

It is possible if the kernel is compiled with CONFIG_PREEMPT
and the calling task has not blocked it.

	HTH
		Oliver
