Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279013AbRJ2FY5>; Mon, 29 Oct 2001 00:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279010AbRJ2FYr>; Mon, 29 Oct 2001 00:24:47 -0500
Received: from ool-18b95509.dyn.optonline.net ([24.185.85.9]:22412 "EHLO
	lfmobile.lmc.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id <S279013AbRJ2FYi>; Mon, 29 Oct 2001 00:24:38 -0500
To: andersen@codepoet.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: r128 + agpgart + APM suspend = death
In-Reply-To: <20011028212006.A9278@codepoet.org>
From: Luis Fernando Pias de Castro <luis@cs.sunysb.edu>
In-Reply-To: <20011028212006.A9278@codepoet.org>
Date: 29 Oct 2001 01:09:39 -0500
Message-ID: <871yjnou3g.fsf@lfmobile.lmc.cs.sunysb.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same for me with an Inspiron 8000. I haven't had much time to look
carefully at it, though. 

-Luis


Erik Andersen <andersen@codepoet.org> writes:

> I have a Dell Latitude C800 laptop.  It works just great and
> I can use agpgart + r128 + XFree86 4.0.1 to get nice full 
> screen 3D.  tuxracer looks nice.
> 
> But if I suspend my laptop when the agpgart module is loaded
> is seems to suspend just fine, but will not resume....  Just
> a black screen (of death).   If I ensure that the agpgart and
> r128 modules are not loaded (by commenting out the 'Load "dri"'
> line in /etc/X11/XF86Config-4, then killing X and unloading 
> the modules) then I can suspend.
> 
> Anyone else seeing similar problems with APM + agpgart?
> The problem has has been the same with all the 2.4.x kernels
> I've tried it on, though I am running 2.4.12-ac6 at the moment.
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
