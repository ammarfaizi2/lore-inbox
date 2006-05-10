Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWEJUfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWEJUfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWEJUfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:35:30 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:40140 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932504AbWEJUf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:35:29 -0400
Date: Wed, 10 May 2006 16:35:01 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Adrian Bunk <bunk@stusta.de>
cc: Daniel Walker <dwalker@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
In-Reply-To: <20060510202401.GS3570@stusta.de>
Message-ID: <Pine.LNX.4.58.0605101634260.22959@gandalf.stny.rr.com>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
 <1147257266.17886.3.camel@localhost.localdomain>
 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <1147273787.17886.46.camel@localhost.localdomain>
 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com> <20060510162404.GR3570@stusta.de>
 <Pine.LNX.4.58.0605101240190.20305@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605101327380.20305@gandalf.stny.rr.com> <20060510202401.GS3570@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Adrian Bunk wrote:

>
> I can't reproduce this, gcc 4.1 gives me:
>
>   CC [M]  init/test.o
> init/test.c: In function 'warn_here':
> init/test.c:14: warning: 'x' is used uninitialized in this function
> init/test.c: In function 'but_not_here':
> init/test.c:23: warning: 'y' is used uninitialized in this function
>

OK, then it's fixed. I just noticed I'm using gcc 4.0.1

-- Steve

