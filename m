Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVKSUyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVKSUyI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKSUyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:54:08 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:4613 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750825AbVKSUyH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:54:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X9tqngCQdZaf4jI6dkHWx/1g+bMtPKVhveskjBIMgnPYfCsytatD0cxJRIlH6WbuaKHsI8o15yby2RzkenEClKp2ZU4Ijo5ZAOK7Ee5x8nzLjBz+sZqP7k0JhZf3OyM9VC5hXnBr5iiV23rzMucpkEqpilF98HCgWSIIBkixrEA=
Message-ID: <3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com>
Date: Sat, 19 Nov 2005 12:54:07 -0800
From: Avuton Olrich <avuton@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel panic: Machine check exception
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1132406652.5238.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
	 <1132406652.5238.19.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sad, 2005-11-19 at 01:45 -0800, Avuton Olrich wrote:
> > CPU 0: Machine Check Exception
> > TSC 17c72bcfba8               4 Bank 4: b200000000070F0F
> > Kernel panic - not syncing: Machine check
>
>
> Thats almost certainly a hardware fault. Machine checks are signalled
> when the processor finds itself in a "can't happen" type of state.

Is there a good way to narrow it down? I guess running a badmem
program would be good to start with, otherwise ...(?).

thanks,
avuton
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
