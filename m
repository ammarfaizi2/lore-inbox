Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVGXODr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVGXODr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 10:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVGXODr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 10:03:47 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:28768 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261356AbVGXODm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 10:03:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hwIAU45SXm0wV9p3JHUZB1hLOkRp+t81RRZQ6wlCh2s6qknmNZN4kmU8cn2cIJUA/C+LaVFlboOR+0OwFnWvC4I3wwkqE6efW8RQIAB0H3Q5hUrFohynVEJFJcwCVMR6f65w+zD+pqhLzO+a3TyNYOptfTXT5slstW5RMyVSCys=
Message-ID: <9a874849050724070358069e59@mail.gmail.com>
Date: Sun, 24 Jul 2005 16:03:39 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: UmaMaheswari Devi <uma@cs.unc.edu>
Subject: Re: kernel debugging
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490507240702593372d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E3946E.4010009@cs.unc.edu>
	 <9a8748490507240702593372d4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 7/24/05, UmaMaheswari Devi <uma@cs.unc.edu> wrote:
> > I am new to kernel hacking and am facing problems in trying to peek at the
> > runtime values of some kernel variables using gdb.
> >
> > I am issuing the gdb command as follows:
> >      gdb vmlinux /proc/kcore
> > This displays the message
> >     /proc/kcore: Operation not permitted
> > before the (gdb) prompt is displayed.
> > gdb then prints a value of 0 for any valid variable that is requested.
> >
> > vmlinux appears to be OK, as gdb correctly identifies undefined variables.
> > The problem seems to be with /proc/kcore. This file has a permission of 400. I
> > am using the Red Hat distribution.
> >
> > Any help is appreciated.
> >
> If you want to use gdb to debug the kernel you should probably
> investigate UML (User Mode Linux). Take a look at this link :
> http://user-mode-linux.sourceforge.net/debugging.html
> 
> Alternatives include kgdb - http://kgdb.sourceforge.net/
> and kdb - http://oss.sgi.com/projects/kdb/
> 
> You can also find many documents on Linux Kernel debugging aids and
> techniques via google.
> 
Ohh, and do search the LKML archives, kernel debuggers have been
discussed endlessly over the years on the list, so you should be able
to find many threads covering that.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
