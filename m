Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWEZXm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWEZXm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWEZXm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:42:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46246 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964868AbWEZXmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:42:55 -0400
Date: Fri, 26 May 2006 16:45:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/13] input: make input a multi-object module
Message-Id: <20060526164543.52f5b8a0.akpm@osdl.org>
In-Reply-To: <447790BB.4060707@gmail.com>
References: <20060526161129.557416000@gmail.com>
	<20060526162902.227348000@gmail.com>
	<20060526141603.054f0459.akpm@osdl.org>
	<44777340.7030905@gmail.com>
	<20060526144309.60469bcd.akpm@osdl.org>
	<447778DA.8080507@gmail.com>
	<20060526150804.0ae11b1f.akpm@osdl.org>
	<44777F98.4080004@gmail.com>
	<20060526153246.267991ed.akpm@osdl.org>
	<44778A14.4060500@gmail.com>
	<20060526162842.4da6b447.akpm@osdl.org>
	<447790BB.4060707@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula <anssi.hannula@gmail.com> wrote:
>
> Andrew Morton wrote:
> > Anssi Hannula <anssi.hannula@gmail.com> wrote:
> > 
> >>Unless you have any more thoughts, I'll make patches for (1) separate
> >>input-ff.o from input.o so that input.c renaming is not required, and to
> >>(2) use the input_dev->event() handler instead of input.o calling
> >>input-ff.o.
> > 
> > 
> > Sounds good, thanks.
> 
> Hmh, I guess I need to send the modified "input: new force feedback
> interface" patch fully again, as the previous patch patches input-core.c
> that doesn't exist if we drop the rename.

yup.

> A final minor question: In your opinion is input-ff.c or ff-effects.c a
> better name? ;)

ff-effects.
