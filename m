Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752416AbWCFT6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbWCFT6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbWCFT6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:58:43 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:59383 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752413AbWCFT6n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:58:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XeJQXdvaC1YpCiZRl0P5VgZcWyOzeTJvZqy0uYxCuTyjdtXfKPUekBp3Tf18IC+WB4JsbosCDDzQ7AxrhUv8dxwonMDMflW9iufYA3p6hgRZV/9SUOvpxiTdeiZGW7CBmoo7f/RSVUkURH/h091WWdv5BcEykdpiqFP2qPCbtaE=
Message-ID: <9a8748490603061158g4213225aq2b0d7a0f98bbd495@mail.gmail.com>
Date: Mon, 6 Mar 2006 20:58:41 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>
In-Reply-To: <200603062051.45555.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <200603061943.35502.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <200603062051.45555.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On Monday 06 March 2006 20:32, Linus Torvalds wrote:
> >
> > seem to be able to recreate it at will. Oh, well. Testign that one patch
> > would still help.
> >
> Hmm, that patch does not apply to the 2.6.16-rc5-mm2 kernel :
>
I fixed it up by hand.
Building a new kernel at the moment - results in a short while.

>
> I'll go see if the problem also exists in mainline - will report on that
> shortly.
>
I'll still do this. Just downloading 2.6.16-rc5-git8 as we speak.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
