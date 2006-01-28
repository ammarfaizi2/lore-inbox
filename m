Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWA1Sbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWA1Sbj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWA1Sbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:31:39 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:39556 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932449AbWA1Sbi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:31:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=srPGEHDuqgCpwFcw5soBbRSipbpKPR1KnvqAkVDBRo98mY/F0+PDLvHY/4Hb5d5jlqGD0flJou1m49TWCsUyOm02He++/Mx3W20uOhyqRjqKXnpl388SDt3Wj27dCCBpkF2cvnc4G7pya3XNUWZ7Zx7yi0PUo8v0dKFwmF+yi2Y=
Message-ID: <9a8748490601281031x514f0b9ckffcdce64148ebd8d@mail.gmail.com>
Date: Sat, 28 Jan 2006 19:31:36 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Ken MacFerrin <lists@macferrin.com>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43DAE307.5010306@macferrin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43DAE307.5010306@macferrin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/06, Ken MacFerrin <lists@macferrin.com> wrote:
> I started getting hard lockups on my desktop PC with the error "kernel
> BUG at mm/rmap.c:487" starting with kernel 2.6.13 and continuing through
> 2.6.14.  After switching to 2.6.15 the lockups have continued with the
> message "kernel BUG at mm/rmap.c:486".
>
> The frequency and circumstance are completely random which originally
> had me suspecting bad memory but after running Memtest86+ for over 12
> hours without error I'm at a loss.
>
> I'm running the binary Nvidia driver so I'll understand if I can't get
> help here but in searching through the list archives it would seem I'm
> not alone and I am willing to try any patches that may help diagnose the
> issue.  The crash happens at least daily and I've seen no difference in
> running kernels with or without PREEMPT enabled.
>
If you don't actually *need* accelerated 3D (or if you could do
without it for a while), switching to the "nv" driver for a few
days/weeks would be interresting. If the crashes go away that would
point towards the nvidia driver, if they don't go away we'll get a
nice untainted crash report.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
