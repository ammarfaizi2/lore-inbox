Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314242AbSE0HXm>; Mon, 27 May 2002 03:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314457AbSE0HXl>; Mon, 27 May 2002 03:23:41 -0400
Received: from smtpde01.sap-ag.de ([194.39.131.52]:51155 "EHLO
	smtpde01.sap-ag.de") by vger.kernel.org with ESMTP
	id <S314242AbSE0HXk>; Mon, 27 May 2002 03:23:40 -0400
From: Christoph Rohland <cr@sap.com>
To: zlatko.calusic@iskon.hr
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.5.18 / ext3 / oracle trouble
In-Reply-To: <877klr2ank.fsf@atlas.iskon.hr>
Organisation: Development SAP J2EE Engine
Date: 27 May 2002 09:23:04 +0200
Message-ID: <d6vi836v.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp (Windows [3]))
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zlatko,

On Sun, 26 May 2002, Zlatko Calusic wrote:
> Hi!
> 
> After lots of testing, I can say that 2.5.18 works great in all
> three modes of ext3 for all but one purpose. Oracle database still
> gets corrupted during insert load. More precisely, online redo log
> gets corrupted, database panics and restore is in order.
> 
> This leads me to thinking that there's something wrong with sysv
> shared memory in 2.5.x. Although the problem could also be in
> fsync() or swap_out() & co. paths, it's yet to be discovered.
> 
> It could also be that journaled mode helps the trouble, and it could
> be that some swapping makes it more certain, but none of these two
> facts are proved for sure. Take it as an observation.
> 
> Christoph, I don't know if you're still taking care of shmem in
> 2.5.x, so take my apologies if you didn't want to see this email.
> 
> Regards,
> -- 
> Zlatko

Unfortunately I do not have the time to work on shmem right now. Hugh
Dickins is the right guy to contact nowadays.

Greetings
		Christoph

