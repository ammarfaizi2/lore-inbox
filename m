Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWCGGmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWCGGmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbWCGGmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:42:12 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:34596 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751842AbWCGGmL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:42:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o/39DWA9051kuDByVBG8HbCacFn9SP1CEXLvh2VIMs12x/wuBcG6vqp04m64AshO6tdGtGXgiyl/f86OnCJcGiajL/Z2NcZfh6QL1x0/2i80gJaJvorVdSwznt882FfLXcAzY069P7TEMWikZynpgzfa8RlvZXWI4UsEXVzuumc=
Message-ID: <105c793f0603062242h4c03b95fy8871e3ee50501ac1@mail.gmail.com>
Date: Tue, 7 Mar 2006 01:42:10 -0500
From: "Andrew Haninger" <ahaning@gmail.com>
To: "tim tim" <tictactoe.tim@gmail.com>
Subject: Re: kernel installation --depmod
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <503e0f9d0603062203x21cdf4e4w4e7da8c0f106fb73@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <503e0f9d0603062203x21cdf4e4w4e7da8c0f106fb73@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, tim tim <tictactoe.tim@gmail.com> wrote:
> hello andrew.. i even tried with modutils & mod init tools but even
> after that we r getting the depmod errors.. i don't think there is a
> problem in make modules.. since  Sam Ravnborg has mentioned something
> that make modules is problem.. can any other suggestions u can offer
> for us..
I don't know what else I can really suggest. Perhaps it's time to find
a distribution that includes the kernel release you want (or a more
recent one).

Please answer the questions Sam asked:

> The warnings you see is a module that references symbols that it cannot
> resolve.
> Do you have a vmlinux in the root of your kernel tree?
Look in your kernel source directory. Is there a file there called "vmlinux"?

> Does Module.symvers include the symbols that you get warnings on?
This file should be found in the root of your kernel tree, too.

> You need to do a successful build of the kernel before you can build
> the modules.
Is the build of the kernel failing, thus leaving certain dependancies
not met for the build of the modules? Do you get any error messages
when you run "make" in the kernel source directory?

Again, unless this is a "just for fun" exercise, it might be more
worth your while to get a different distribution with all of this
stuff preconfigured.

-Andy
