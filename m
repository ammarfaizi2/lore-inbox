Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWAIBiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWAIBiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 20:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWAIBiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 20:38:11 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:16533 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751499AbWAIBiK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 20:38:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZOqQQwnS74dXu2pVxcrkAVcmCaOUDjO1lnsPDYLkVNGB6ZJwJi48FECUPxIfpt34d9GWJjSnrWV9Tsg+Ey0IjrjEHw+tAVLRFlddZe89DgIbtLg68AHL8BfVbKikw+m4w3DJXg7/aTAp9QbRWRwUrklpwJbj+dkbKpQfqF9ml1w=
Message-ID: <2cd57c900601081737o2c6262e8m@mail.gmail.com>
Date: Mon, 9 Jan 2006 09:37:06 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Deven Balani <devenbalani@gmail.com>
Subject: Re: patch for splice system call.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7a37e95e0512122239p34d0f436k30227f7f62a2e437@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7a37e95e0512122239p34d0f436k30227f7f62a2e437@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/13, Deven Balani <devenbalani@gmail.com>:
> Hi All!
>
> I am routing data from a tuner to harddisk.
> I came to know splice() is something related to do real-time IO.
> I believe direct IO doesn't address this scenario.
>
> Can any one refer me the source to the patch of splice() system call.
>

sendfile (2) ?

> Regards,
> Deven
>
> On 12/9/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> > On 12/9/05, Deven Balani <devenbalani@gmail.com> wrote:
> > > I am writing a libata-complaint SATA driver for an ARM board.
> > >
> > > I want to do data streaming from a tuner into the SATA hard disk.
> > >
> > > In other words, I am getting a buffer of stream in kernel space, which
> > > I had to store it in SATA hard disk.
> >
> > can this be of interest:
> >
> > http://groups.google.de/group/fa.linux.kernel/browse_frm/thread/21b2b3215f35e21a/bcbc00b7a0151afd?tvc=1&q=linux-kernel+Make+pipe+data+structure+be+a+circular+list+of+pages#bcbc00b7a0151afd
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Coywolf Qi Hunt
