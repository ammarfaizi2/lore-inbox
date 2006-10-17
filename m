Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWJQKRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWJQKRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 06:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWJQKRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 06:17:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:24734 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161047AbWJQKRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 06:17:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uLL8vTQ2AJY8mieHcr33RppC9xVVec+dxwW9/8G3XzHRlgsYrPwVsOIm9isW2r+vlgyln791f2fdgsWIPbYo72e+1x0wpxsX5Z2u9rd6nrmMfi5ooaNDUt9OhFgsE/RGpm4whvRrldqmHHAAjptsLWZINBEqZkH9lvGIV26ypJk=
Message-ID: <3420082f0610170317n7a712a4du9801c86506f51389@mail.gmail.com>
Date: Tue, 17 Oct 2006 15:17:16 +0500
From: "Irfan Habib" <irfan.habib@gmail.com>
To: "Jay Vaughan" <jv@access-music.de>
Subject: Re: getting a return from a system call
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <a06230915c15a5acf6842@192.168.2.100>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3420082f0610170245x1a3fa82ft88246b25cab09942@mail.gmail.com>
	 <a06230915c15a5acf6842@192.168.2.100>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and what about long? I tried return type long, it also always returned
0, instead of the custom one I was returning

On 10/17/06, Jay Vaughan <jv@access-music.de> wrote:
>
> You can't use floats in kernel system calls ..
>
> j.
>
> At 14:45 +0500 17/10/06, Irfan Habib wrote:
> >Hi,
> >
> >I'm trying to build a system call which returns a float, and is defined as :
> >asmlinkage float sys_ph_pinfo(int pid, int mode)
> >
> >but in a user level program every time, I evaluate it, I always get
> >a return 0!
> >How do I capture the return of a system call?
> >
> >Also is it possible that a system call return a structure or array?
> >Will that be available in user space? My hunch is that this is not
> >possible, as kernel memory space is disjoint form the user memory
> >space, but just for information.
> >
> >Regards,
> >Irfan
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
>
>
> --
>
> ;
>
> Jay Vaughan
>
>
