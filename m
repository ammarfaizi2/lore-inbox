Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbVJ0XXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbVJ0XXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 19:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVJ0XXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 19:23:03 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:57281 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932690AbVJ0XXB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 19:23:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CGcLfdJYEOJFgfQP8k3fxM57BXeqprgfGV0opYhjNY+yq5pclFALQtnRuZxDYT/GMWpYRu3eKV/qY/nj5AjL4GwA8/20JJp6ZONBf6Ypios2wmcEHaK3N+MkRZ4gGiHn/B0TWJSBcrJ+/vgxcQXFmWnCp1YmEjmTVZoF4s8SOPc=
Message-ID: <5a2cf1f60510271623n3a33f057sf69c4b3b955c1dd8@mail.gmail.com>
Date: Fri, 28 Oct 2005 01:23:00 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, vojtech@suse.cz,
       akpm@osdl.org
In-Reply-To: <200510272003.26560.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510271026.10913.ak@suse.de>
	 <200510272003.26560.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Ingo Oeser <ioe-lkml@rameria.de> wrote:
> Hi Andi,
>
> On Thursday 27 October 2005 10:26, Andi Kleen wrote:
> > Remove most useless printk in the world
>
> *clap* *clap*
>
> Thanks!
>
> It usally triggers, if your cat, child, bird whatever handles your keyboard or
> you accidentally put a book or sth. on it (e.g while the screen has been
> locked).
>
> So there is really no use for it, except for kernel debugging,
> where it can be wrapped up by pr_debug() or similiar.

I am not the fastest typer on Earth, far from it.

I use to have this printed all over the place on my Dell Inspiron 8100
laptop, without really doing anything special with my keyboard....

So I don't know if this was an issue or not, but given that my
keyboard never caused me a trouble, I just brain blacklisted the
message.

Thanks a lot for making this simple yet effective patch :)

Cheers,

Jerome
