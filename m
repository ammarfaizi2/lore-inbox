Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285168AbRLFQzl>; Thu, 6 Dec 2001 11:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285051AbRLFQzc>; Thu, 6 Dec 2001 11:55:32 -0500
Received: from firebird.epm.se ([194.52.86.60]:18695 "EHLO www.voxi.se")
	by vger.kernel.org with ESMTP id <S285155AbRLFQzV>;
	Thu, 6 Dec 2001 11:55:21 -0500
Message-ID: <3C0FB379.4675B275@voxi.com>
Date: Thu, 06 Dec 2001 19:05:45 +0100
From: Erland Lewin <erl@voxi.com>
Organization: Voxi AB
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Christian Robottom Reis <kiko@async.com.br>
Subject: Re: /proc/<pid>/stat read hang with Mozilla in 2.4.14
In-Reply-To: <3C0F510C.E535A9A8@voxi.com> <3C0F9A53.10508@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote of hangs reading various /proc/<pid>/files after a Mozilla
crash.

Manfred Spraul replied:
> 
> Could you check if mozilla was in the middle of a coredump? There is a
> deadlock in the coredump handler, perhaps mozilla triggered it.
> Could you search for a recent coredump file?
> 

Yes, I found a matching core dump (core.8770).
  Is there any other information I can help with?
  What is the status of the deadlock problem - has it been fixed in the
latest kernel?

> Or check if PF_DUMPCORE is set in tsk->flags. (Probably difficult
> without access to /proc/n/stat)

/Erland
