Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVGXTBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVGXTBK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 15:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVGXTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 15:01:10 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:41860 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261444AbVGXTBK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 15:01:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dHYZ6+4zCxYT4TZDT4eoZdaZ13HuL0cpDZ9hS3EudqSzsZPLPElHD4eiIryWp2dpEuoxfYX9xjiAO/N2B/kzPA/sKaA/6zfJzdQXv0Sx4dPrrksk5GHtJH83gO0rDsW3LEdUa9yVYuHVKjkflySSvq8tEL+DBvUMjmD3UcfipFg=
Message-ID: <4536bb7305072412011fbeaf59@mail.gmail.com>
Date: Mon, 25 Jul 2005 00:31:07 +0530
From: VASM <vasm85@gmail.com>
Reply-To: VASM <vasm85@gmail.com>
To: Nix <nix@esperi.org.uk>
Subject: Re: kernel page size explanation
Cc: Jesper Juhl <jesper.juhl@gmail.com>, gbakos@cfa.harvard.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <87d5p8aw4h.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu>
	 <9a87484905072118207a85970e@mail.gmail.com>
	 <87d5p8aw4h.fsf@amaterasu.srvr.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i had one question 
does the linux kernel support only one default page size even if the
processor on which it is working supports multiple ?

On 7/25/05, Nix <nix@esperi.org.uk> wrote:
> On 22 Jul 2005, Jesper Juhl suggested tentatively:
> > You can
> >  A) look in the .config file for your current kernel (if your arch
> > supports different page sizes at all).
> >  B) You can use the  getpagesize(2) syscall at runtime. getpagesize()
> > returns the nr of bytes in a page - man getpagesize - I'm not sure
> > that's universally supported though.
> >  C) You can look at /proc/cpuinfo or /proc/meminfo , IIRC some archs
> > report page size there - not quite sure, can't remember...
> 
> D) getconf PAGE_SIZE should work, although what it does on arches
>   with variable page sizes isn't clear to me.
> 
> --
> `But of course, GR is the very best relativity for the masses.'
>  --- Wayne Throop
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
