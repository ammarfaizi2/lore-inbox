Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVGGUTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVGGUTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVGGURD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:17:03 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:18071 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261374AbVGGUQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:16:52 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-RT-V0.7.51-12 and x86-64
Date: Thu, 7 Jul 2005 21:16:52 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507072106.31970.s0348365@sms.ed.ac.uk> <20050707201444.GB2905@elte.hu>
In-Reply-To: <20050707201444.GB2905@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507072116.52224.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Jul 2005 21:14, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > Latest patch doesn't compile on non-i386 arches. I found all users of
> > INIT_FS; need to be audited to INIT_FS(init_fs); like i386; then it
> > compiles fine.
>
> thx, i've put this fix into -51-14.
>

Looks like this isn't sufficient to make things work. Userspace segfaults 
(i.e. anything I pass with init= just screams about a segfault over and 
over).

> > Ingo, could you also respond to my other thread, I uploaded the
> > screenshot you requested.
>
> unfortunately they dont show any other info, other than somewhere a
> pagefault happened. I suspect only serial logging would help.

OK, I'll find time to do this later.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
