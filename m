Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289662AbSAJUla>; Thu, 10 Jan 2002 15:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289661AbSAJUlV>; Thu, 10 Jan 2002 15:41:21 -0500
Received: from ns.suse.de ([213.95.15.193]:12295 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289662AbSAJUlF>;
	Thu, 10 Jan 2002 15:41:05 -0500
Date: Thu, 10 Jan 2002 21:41:04 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Peter Jones <pjones@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] #ifdef __cplusplus removal (fwd)
In-Reply-To: <Pine.LNX.4.33.0201101527140.7586-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0201102139390.9236-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Peter Jones wrote:

>  And again for my bad email aliases :)
> This patch removes the "#ifdef __cplusplus" from within a "#ifdef
> __KERNEL__" in linux/string.h.  It really isn't needed AFACIT.  It was
> put
> in for 1.1.0, which was before __KERNEL__ appeared.  Alan told me to
> send it to you.

A quick grep shows __cplusplus is used in quite a few places in the kernel
source. I'm wondering if various developers are running their code through
g++ to maybe pick up on warnings that gcc doesn't see.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

