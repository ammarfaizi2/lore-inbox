Return-Path: <linux-kernel-owner+w=401wt.eu-S1426241AbWLHUCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426241AbWLHUCn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426244AbWLHUCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:02:43 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:37666 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426241AbWLHUCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:02:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CDSv+l9E9EzjmWU2zrsmv1Q6/pjqs0noQkFfaeLwtWVUbohMRw2XXOqJ6NrApAHQTDv7lJeARwl9/aTGakWMROjGBXhybudvSoh1oUIj4VPaoYKqvsIM9mxH8XHiibxlAeJe16OBtTd4xKxPdrd2tu+mXbNBoZJqGranDKeVnLI=
Message-ID: <9a8748490612081202n752529c1x84afacb07547e767@mail.gmail.com>
Date: Fri, 8 Dec 2006 21:02:40 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: NFS related BUGs at shutdown - do_exit() + lock held at task exit time - 2.6.17.8
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net, "Neil Brown" <neilb@suse.de>
In-Reply-To: <1165601022.5676.22.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490612080341j4f0fa7b5l2f7272df0df55073@mail.gmail.com>
	 <1165601022.5676.22.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Fri, 2006-12-08 at 12:41 +0100, Jesper Juhl wrote:
> > Greetings,
> >
> > I just got a kernel crash when shutting down a webserver. Nothing made
> > it to the logs, but I managed to get a photo of the dump on screen :
> > http://www.kernel.org/pub/linux/kernel/people/juhl/images/2.6.17.8-kernel-crash.jpg
>
> It is hard to see what is going on there. AFAICS, the more interesting
> stuff to do with the Oops itself has scrolled off the screen. Any chance
> it may have been syslogged?
>
Unfortunately no - I checked. All I have is that photo :-(

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
