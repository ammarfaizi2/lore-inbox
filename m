Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWGPGSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWGPGSc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 02:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGPGSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 02:18:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:46275 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750785AbWGPGSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 02:18:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r3J226icQ3VnJaqvzgf0dHaAk6CnZl19cp3tgenm+VQqqSIV//QCvD7oke2/1pBDs4MFkrEEV7mIZF1evNPhRZYmzpcRfPeGSxVEt//kALuZz3wkdnW8mUYAfE3ByBgjmAM2wP6oIY9lXgyspTfqODnX1zL0VICS/+6yG93cb+I=
Message-ID: <787b0d920607152318o72634affhbb51b3826f8daee5@mail.gmail.com>
Date: Sun, 16 Jul 2006 02:18:30 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: 2.6.18 Headers - Long
Cc: arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <1153000020.8427.16.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
	 <1153000020.8427.16.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Sat, 2006-07-15 at 17:09 -0400, Albert Cahalan wrote:

> > Don't blame app developers if they go for what is good.
> > To stop them, provide the goodness in a sane way.
> > (alternately, make the Linux code suck ass more than POSIX)
>
> Kernel headers are _not_ a library of random crap for userspace to use.

Says you, and a number of other people around here.
App developers seem to feel differently. Accept reality.

> There is no justification for asm/atomic.h being installed
> in /usr/include. Especially since, as Arjan points out, it doesn't
> actually provide atomic operations in many cases anyway.

It's fixable via #ifdef __KERNEL__ of course.

> However, the kernel is released under a licence which allows you to
> re-use code from it if you really want.

Well, ideally it'd be LGPL, but yes.

> If you want to provide a
> 'libkernelstuff', the GPL permits you to do that. The kernel's ABI
> headers (and lkml) are not the appropriate place for such a project

Perhaps. This is duplication of effort though.

You're the person trying to change the app developers.
If you want to change them, provide an alternative that
doesn't totally suck ass.

> Btw, your mail client omitted the References: and In-Reply-To: headers
> which RFC2822 says it SHOULD have included. On a list with as much
> traffic as linux-kernel, that's _very_ suboptimal, because you've
> detached your message from the thread to which you replied. Please try
> to fix or work around that.

Most clients won't allow adding such headers manually.
I don't actually subscribe to the list. Most clients won't
expire old list traffic, and I certainly can't have lkml pour
unhindered into my inbox. It really doesn't work for me,
so I cut and paste from a list archive. Sorry. Ideas are
welcome of course, but I'm not expecting any reasonable
solution to exist.
