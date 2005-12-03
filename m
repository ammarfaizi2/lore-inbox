Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVLCO34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVLCO34 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 09:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVLCO3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 09:29:55 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:22418 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751260AbVLCO3z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 09:29:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pmcUu1AzRDUxt62OhcrkGmp7Dj8xoDLp6FyhkM+x50sTlkTJKIsE+OEpN3hkBl2C48g/Xzv7vgk3h5/0Lt2pDTh/GwPVEfF4fG+nyBbGrsxx3134DcKxSX1/nD7FMTBMnEALbPFAj2zPznUlCR2xG6vFErzLGJt3mD6DUmkdXlk=
Message-ID: <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
Date: Sat, 3 Dec 2005 15:29:54 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051203135608.GJ31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/05, Adrian Bunk <bunk@stusta.de> wrote:
> The current kernel development model is pretty good for people who
> always want to use or offer their costumers the maximum amount of the
> latest bugs^Wfeatures without having to resort on additional patches for
> them.
>
> Problems of the current development model from a user's point of view
> are:
> - many regressions in every new release
> - kernel updates often require updates for the kernel-related userspace
>   (e.g. for udev or the pcmcia tools switch)
>
> One problem following from this is that people continue to use older
> kernels with known security holes because the amount of work for kernel
> upgrades is too high.
>
> These problems follow from the development model.
>
> The latest stable kernel series without these problems is 2.4, but 2.4
> is becoming more and more obsolete and might e.g. lack driver support
> for some recent hardware you want to use.
>
> Since Andrew and Linus do AFAIK not plan to change the development
> model, what about the following for getting a stable kernel series
> without leaving the current development model:
>
>
> Kernel 2.6.16 will be the base for a stable series.
>
[snip]

Why can't this be done by distributors/vendors?

Any vendor is free to branch off at 2.6.<whatever> and then maintain
that indefinately.  Why create yet-another-stable-branch?

In effect you'd be making 2.6.17+ into a 2.7.x tree and 2.6.16.y would
become a 2.6 tree in 2.4.x style, with all the backporting problems
and vendor skew that 2.4.x suffered from.

Personally I don't like this proposal. In my oppinion 2.6 + the
-stable branch as we have it now works well and people who want
userspace & kernel in sync are perfectly free to use vendor kernels
(which is also the recommended thing to do for most users as far as I
know).

Just my 0.02euro.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
