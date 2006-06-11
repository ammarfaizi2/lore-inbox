Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWFKUoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWFKUoW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWFKUoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 16:44:21 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:46020 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S1751001AbWFKUoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 16:44:21 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [patch] i386: use C code for current_thread_info()
Date: Sun, 11 Jun 2006 21:44:26 +0100
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <200606111512_MC3-1-C229-37D@compuserve.com> <Pine.LNX.4.61.0606112141440.9782@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606112141440.9782@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606112144.26705.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 June 2006 20:42, Jan Engelhardt wrote:
> >Using C code for current_thread_info() lets the compiler optimize it.
> >With gcc 4.0.2, kernel is smaller:
> >
> >    text           data     bss     dec     hex filename
> > 3645212         555556  312024 4512792  44dc18 2.6.17-rc6-nb-post/vmlinux
> > 3647276         555556  312024 4514856  44e428 2.6.17-rc6-nb/vmlinux
> > -------
> >   -2064
>
> If possible, can you or someone post the results for x86_64?

Patch is for i386, x86_64's current_thread_info() is already C.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
