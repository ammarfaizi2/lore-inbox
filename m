Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVGEJUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVGEJUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 05:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVGEJUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 05:20:20 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:51566 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261751AbVGEJUP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 05:20:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s9U/86KZJcug0zYY/PpZLoUf9XTsPD35atYNsrra0LXjaIHJ3gP0RS4Lhva3lUW08UI/UCRiUBu/ruFURi+SLSBEYX/b846ywx0hwcMKXUJVGYzgrnI1iYZc8CVXU6RBTFH5DDT1aOweVQPNVwI/MlZg21ob3Dc9ao4vUDefOi0=
Message-ID: <58cb370e050705022010930552@mail.gmail.com>
Date: Tue, 5 Jul 2005 11:20:09 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [SOLVED] Re: [2.6.11.10][Ali15x3] Crash at startup after disks detection in DMA66 mode
Cc: THESNIERES Sylvain <tmsec@free.fr>
In-Reply-To: <58cb370e05060608551a4d2c85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1117806619.42a0601b371b8@imp5-q.free.fr>
	 <58cb370e05060608452a6a1ce0@mail.gmail.com>
	 <58cb370e05060608551a4d2c85@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not a bug.

"ide0=66" kernel parameter forces settings for ide0:
IO base at port 66, default control port and IRQ.

Just don't use "ide0=66".

On 6/6/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 6/6/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On 6/3/05, THESNIERES Sylvain <tmsec@free.fr> wrote:
> > > Hello. I used the kernel 2.6.10-gentoo-rc9 with my notebook (Pentium 4-M, no
> > > trademark), it worked fine and I updated to 2.6.11.10 with fbsplash patch, and
> > > now DMA causes the system to crash at boot time. I can't dump any message,
> >
> > Could you elaborate on "DMA causes the system to crash"?
> >
> > Does 2.6.10-rc5 work for you?
> 
> Ehm, 2.6.12-rc5 :-)
>
