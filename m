Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVIMPuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVIMPuE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVIMPuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:50:04 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:42311 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964810AbVIMPuB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:50:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Eqn9z07KFlP6jo07DGubBeB6P88XPs0+k9reNE2iN6/Cwhf7+lEw1VLFLR/djZWyUdn39ChaM79fJyZOaaX6jxYDljFaChNfA+tmBSaYFavAXxShNQG3VjZ0GDxV8ek/d7twKspWOGp+glZqhHPDtnfOlizGl9XfeaH/uLrSUw8=
Message-ID: <9a8748490509130850672ab774@mail.gmail.com>
Date: Tue, 13 Sep 2005 17:50:00 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: iSteve <isteve@rulez.cz>
Subject: Re: query_modules syscall gone? Any replacement?
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <4326F093.80206@rulez.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4KSFY-2pO-17@gated-at.bofh.it> <E1EDpQq-0000iV-Oe@be1.lrz>
	 <4326DE0E.2060306@rulez.cz>
	 <Pine.LNX.4.50.0509130813010.7614-100000@shark.he.net>
	 <4326F093.80206@rulez.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/05, iSteve <isteve@rulez.cz> wrote:
> > Nope, they are not prevented.  However, there is a Tainted flag
> > that is set when one is loaded (and that flag is never cleared).
> >
> 
> Okay, I've been wrong in my conclusion and I gotta read some fine manual
> about how the modules actually work -- could you recommend me some in
> particular?
> 

Well, the depmod(8), lsmod(8), insmod(8), modprobe(8), modules.dep(5),
depmod.old(8) and modprobe.conf(5) man pages all have various bits of
info.

There's also some info in chapter 2 of "Linux Device Drivers, Third
Edition" - http://lwn.net/images/pdf/LDD3/ch02.pdf

Then there's The Linux Kernel Module Programming Guide -
http://www.tldp.org/LDP/lkmpg/2.6/html/

As well as the Linux Loadable Kernel Module HOWTO -
http://www.tldp.org/HOWTO/Module-HOWTO/

Also take a look at the file Documentation/kbuild/modules.txt in your
kernel source dir.


That's just a little bit of reading material for you :)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
