Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVIQP4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVIQP4K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVIQP4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:56:10 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:1996 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751123AbVIQP4J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:56:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XQiGfVYLT3piFvyeMWBu663xb+56vmCI2AM3BeAbE9zYQqCYXqr70KRr1rCsQ4pnwgdPJbD70j9+9LLPpxuEdudedHf+PVh+EBpJIEirEZ+JJizOpw5GqIhw858L1wnpzp71ci6U2QDzZYcuuZz8I4HucTF/L0KwuPVUgm7NDHU=
Message-ID: <9a8748490509170856a1b9428@mail.gmail.com>
Date: Sat, 17 Sep 2005 17:56:08 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [i386 BOOT CODE] kernel bootable again
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1rhnij9opqgby$.4jlz2jfqsmkc$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192>
	 <432722A1.8030302@tuxrocks.com> <43272B9D.1030301@zytor.com>
	 <33296.85.68.36.53.1126690932.squirrel@212.11.36.192>
	 <1rhnij9opqgby$.4jlz2jfqsmkc$.dlg@40tude.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/05, Giuseppe Bilotta <bilotta78@hotpop.com> wrote:
> On Wed, 14 Sep 2005 11:42:12 +0200 (CEST), Pascal Bellard wrote:
> 
> > The bootblock code is 497 bytes long. It must as simple as possible.
> > Complex algorithms like fingerprinting can't be used.
> >
> > Geometry detection works with usual floppies. This patch goal is to
> > support them like < 2.6 bootblocks did and fix 1M limitation and
> > special formatting like 1.68M floppies.
> >
> > Geometry detection may work with non-traditional floppies but is not
> > designed to.
> 
> This is probably a stupid suggestion, but here it goes anyway: the
> kernel has to be written on disk by something, right?
> 
> So if the "something" knows (or can get to know) the sector/tracks
> layout of the disk it's writing the kernel onto, it could store this
> information in the bootblock (is there space for that?). The bootblock
> code would then just read this info and use it.
> 
> Of course, this would mean that making a kernel-bootable floppy
> wouldn't be as simple as cp'ing the kernel image to /dev/fdwhatever,
> but if a script/program designed to do this was included with the
> kernel source (it wouldn't be too big ...) ...
> 
I may be missing something here, but if you are going to do something
like that, then why not just use a real bootloader instead?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
