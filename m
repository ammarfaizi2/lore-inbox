Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVLSOoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVLSOoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVLSOoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:44:13 -0500
Received: from mail.gmx.de ([213.165.64.21]:48095 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932101AbVLSOoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:44:13 -0500
X-Authenticated: #4399952
Date: Mon, 19 Dec 2005 15:44:10 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-rt2 build error
Message-ID: <20051219154410.4942e826@mango.fruits.de>
In-Reply-To: <43A5DBF0.6030801@cybsft.com>
References: <20051218210614.75f424eb@mango.fruits.de>
	<43A5DBF0.6030801@cybsft.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Dec 2005 16:00:16 -0600
"K.R. Foley" <kr@cybsft.com> wrote:

> Florian Schmidt wrote:
> > config attached [cat .config|grep -v "#" >config]
> > 
> >   CC      lib/rwsem.o
> > lib/rwsem.c: In function '__rwsem_do_wake':
> > lib/rwsem.c:57: warning: implicit declaration of function 'rwsem_atomic_update'
> > lib/rwsem.c:57: error: 'RWSEM_ACTIVE_BIAS' undeclared (first use in this function)

> Flo,
> 
> Look back through the mailing list for the past week for a thread
> entitled "kernel-2.6.15-rc5-rt2 - compilation error" and check out
> Steven's patches in that thread. If you can't find it let me know.

Thanks, i found this:

http://lkml.org/lkml/mbox/2005/12/14/246

I'm not on X86_64 though. Plus i do have PREEMPT_RT enabled.

trying this though:

http://lkml.org/lkml/2005/12/13/184

Seems to build fine now.

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
