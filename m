Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130440AbRACOi4>; Wed, 3 Jan 2001 09:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRACOip>; Wed, 3 Jan 2001 09:38:45 -0500
Received: from [196.38.105.82] ([196.38.105.82]:38917 "EHLO www.webtrac.co.za")
	by vger.kernel.org with ESMTP id <S130440AbRACOij>;
	Wed, 3 Jan 2001 09:38:39 -0500
Date: Wed, 3 Jan 2001 16:08:02 +0200
From: Craig Schlenter <craig@qualica.com>
To: linux-kernel@vger.kernel.org
Subject: Re: strange swap behaviour - test11pre4
Message-ID: <20010103160802.A8544@qualica.com>
In-Reply-To: <20010103123230.C23323@qualica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010103123230.C23323@qualica.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip, vmstat stuff, me]
> There is a perl program running (80 Meg's in size, 20 Megs resident) that is
> chatting to a database and building up a large hash in memory. The machine has
> 64M of RAM. The bit that doesn't make sense is why the cache is so large -
> the VM seems to have got stuck paging in stuff from swap repeatedly (bits of
> the perl program it would seem). Surely it should shrink the cache to provide 
> more breathing room or am I being an idiot about this?

$idiot++;

> Should I be running a different kernel? 2.2.19preXXX ? Should I be tuning
> vm things in proc and if so how?

Hmmmm ... I think more RAM will help. I was hoping that it was some
VM problem but having tested 2.2.19pre5 now (which does seem 'better' -
it keeps about 45M of the program resident) it seems as if program 
really is keen on actually using most of the 80Megs it has allocated
... sheesh ... it makes mozilla look lean.

My apologies for the noise ...

--Craig
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
