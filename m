Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVFGGhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVFGGhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 02:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVFGGhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 02:37:46 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:31654 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261810AbVFGGhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 02:37:41 -0400
Date: Tue, 7 Jun 2005 08:37:31 +0200
From: Voluspa <lista1@telia.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Linux v2.6.12-rc6
Message-Id: <20050607083731.5edfd276.lista1@telia.com>
In-Reply-To: <20050607061831.GA6957@elte.hu>
References: <20050607081116.65c10190.lista1@telia.com>
	<20050607061831.GA6957@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2005 08:18:31 +0200 Ingo Molnar wrote:
> 
> * Voluspa <lista1@telia.com> wrote:
> 
> >   CC      arch/x86_64/kernel/irq.o
> >   CC      arch/x86_64/kernel/ptrace.o
> > arch/x86_64/kernel/ptrace.c: In function `putreg':
> > arch/x86_64/kernel/ptrace.c:285: error: duplicate case value
> > arch/x86_64/kernel/ptrace.c:280: error: previously used here
> > make[1]: *** [arch/x86_64/kernel/ptrace.o] Error 1
> > make: *** [arch/x86_64/kernel] Error 2
> 
> builds fine here - and i cannot see how those case values could be 
> duplicate. Are you sure your build is completely clean?

Ah, sorry about the noise... I've been away from kernel testing too
long. I patched a 2.6.11.11 tree without noticing all the rejects (this
new machine is fast). But from what I remember, it was decided to do
the -rc patches against the latest stable codebase, in this case .11
Shrug.

Mvh
Mats Johannesson
--
