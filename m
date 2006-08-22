Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWHVOZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWHVOZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWHVOZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:25:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1290 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751387AbWHVOZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:25:19 -0400
Date: Tue, 22 Aug 2006 16:25:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
Message-ID: <20060822142519.GX11651@stusta.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <1156254965.27114.17.camel@localhost.localdomain> <1156254322.2976.55.camel@laptopd505.fenrus.org> <200608221550.57603.ak@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608221550.57603.ak@muc.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 03:50:57PM +0200, Andi Kleen wrote:
> 
> > this would need a "const after boot" section; which is really not hard
> > to make and probably useful for a lot more things.... todo++
> 
> except for anything that needs tlb entries in user space. And it only gives you
> false sense of security. --todo

What's the alternative?

Change it from a struct to a compile time choice?
This should address both the security concerns and your tlb issues at 
the price of runtime flexibility.

> -Andi

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

