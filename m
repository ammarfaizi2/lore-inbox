Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSGEKiO>; Fri, 5 Jul 2002 06:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSGEKiN>; Fri, 5 Jul 2002 06:38:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7352 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316869AbSGEKiN>;
	Fri, 5 Jul 2002 06:38:13 -0400
Date: Fri, 5 Jul 2002 12:40:37 +0200
From: Jens Axboe <axboe@suse.de>
To: venom@sns.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
Message-ID: <20020705104037.GM1007@suse.de>
References: <Pine.LNX.4.43.0207051217160.8506-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0207051217160.8506-100000@cibs9.sns.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05 2002, venom@sns.it wrote:
> 
> HI,
> I was trying kernel 2.5 with TCQ enabled.
> I tried it on three Desktar disk (manufactured in Thailand
> in february 2001) model dtla 305020.
> 
> All three disk died after some week, without
> any signal of being dying.
> I was starting to suspect about an HW problem.
> 
> With 2.4 kernels, no tcq, they could work
> without any problem for almost 8 months, but now,
> I moved those disk to test systems to test tcq support
> and all died badly. This is not an heat problem, since
> thay staty in a CED conditioned at 18C.

This is a puzzling report. I wouldn't recommend that anyone use tcq in
2.5 actually, since even I do not know what state it is currently in. I
would seriously recommend 2.4 + tcq patches instead.

That said, are your disks completely dead now? As in they do not work
with a regular 2.4 kernel anymore?!

-- 
Jens Axboe

