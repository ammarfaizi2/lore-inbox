Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316457AbSEUATk>; Mon, 20 May 2002 20:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316458AbSEUATj>; Mon, 20 May 2002 20:19:39 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:10411 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316457AbSEUATi>;
	Mon, 20 May 2002 20:19:38 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15593.37444.727156.95715@argo.ozlabs.ibm.com>
Date: Tue, 21 May 2002 10:18:12 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <15593.36080.660343.246677@argo.ozlabs.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> The UP optimization would be slower on "classic" PPCs because you end
> up doing a flush_tlb_mm rather than flushing the ranges of addresses
> where there are actually PTEs present.

Of course, the part of the UP optimization where we free the page
immediately would still apply on classic PPC.

Paul.
