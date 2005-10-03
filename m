Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVJCILg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVJCILg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 04:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVJCILg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 04:11:36 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:60368 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S932189AbVJCILe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 04:11:34 -0400
From: David Lang <david.lang@digitalinsight.com>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, suparna@in.ibm.com,
       bcrl@kvack.org, sebastien.dugue@bull.net
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: dlang@dlang.diginsite.com
References: dlang@dlang.diginsite.com
Date: Mon, 3 Oct 2005 01:11:05 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: AIO Support for kernel 2.6.11 ?????? 
In-Reply-To: <20051003075519.98008.qmail@web8409.mail.in.yahoo.com>
Message-ID: <Pine.LNX.4.62.0510030107260.11095@qynat.qvtvafvgr.pbz>
References: <20051003075519.98008.qmail@web8409.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch support for 2.6.11 was terminated when 2.6.12 was released (and 
support for 2.6.12 was then terminated when 2.6.13 was released)

this is the way kernel development works.

anyone (including you) is allowed to pick a release and provide patch 
support for i, including backporting features from later kernels. most 
distributions do this to a greater or lesser degree.

don't expect patches from leter kernels to apply cleanly. if they do you 
are lucky, if they don't then you need to apply the 'modification; you 
mention in point3 until they do work, however you will be pretty much on 
your own for doing that work.

I can't answer your specific questions about AIO so I'll leave it at that.

David Lang

On Mon, 3 Oct 2005, vikas gupta wrote:

> Date: Mon, 3 Oct 2005 08:55:19 +0100 (BST)
> From: vikas gupta <vikas_gupta51013@yahoo.co.in>
> To: linux-aio@kvack.org, linux-kernel@vger.kernel.org, suparna@in.ibm.com,
>     bcrl@kvack.org, sebastien.dugue@bull.net
> Subject: AIO Support for kernel 2.6.11 ?????? 
> 
> hi All
>
> 1) I like to ask why patch support is not provided for
> 2.6.11 kernel....
>
> 2) What needs to be done in order to use 2.6.11 kernel
> with full AIO Support
>
> 3) Is it possible to apply 2.6.13-rc6-B0-all.diff
> patch provided by ben to2.6.11 kernel after some
> modification,and if that is done whether i be able to
> get full kernel AIO Support
>
> 4) if i applied suparna's patches with
> linux-2.6.12-PAIO-0.6.tar on linux-2.6.12-rc6 kernel,I
> am getting Some errors with respect to suparna's
> patches.Thay are not getting applied cleanly...
> So i am trying to manually applied them ...but will i
> be able to Full AIO Support after
> applying those patches on linux-2.6.12-rc6 .
>
>
> vikas
>
>
>
>
>
>
>
> __________________________________________________________
> Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
