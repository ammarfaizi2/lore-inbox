Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUGMInm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUGMInm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 04:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUGMInm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 04:43:42 -0400
Received: from witte.sonytel.be ([80.88.33.193]:32951 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264550AbUGMInl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 04:43:41 -0400
Date: Tue, 13 Jul 2004 10:43:39 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Titz <olaf@bigred.inka.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <E1BjmAw-0005MS-00@bigred.inka.de>
Message-ID: <Pine.GSO.4.58.0407131042310.6985@waterleaf.sonytel.be>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org> <m1smc09p6m.fsf@ebiederm.dsl.xmission.com>
 <E1BjmAw-0005MS-00@bigred.inka.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Olaf Titz wrote:
> in C. (Worse in C++ where usage of NULL is discouraged, I've always
> wondered about the reasons.)

[ wondered about this as well, but the answer has been posted before in this
  thread ]

Because C++ doesn't do implicit conversions from void * to anything *.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
