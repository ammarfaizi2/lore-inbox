Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbUCPDPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 22:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUCPDPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 22:15:44 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:56779 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262863AbUCPDPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 22:15:34 -0500
MIME-Version: 1.0
Date: Tue, 16 Mar 2004 12:15:08 +0900
Subject: Re: Hugetlbpages in very large memory machines.......
From: Nobuhiko Yoshida <n-yoshida@pst.fujitsu.com>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Cc: raybry@sgi.com, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-ID: <JM20040316121508.13008671@pst.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20040316015401.GF9931@wotan.suse.de>
References: <20040316015401.GF9931@wotan.suse.de>
X-Mailer: JsvMail 5.0 (Shuriken Pro3)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > +/*      update_mmu_cache(vma, address, *pte); */
> 
> I have not studied low level IA64 VM in detail, but don't you need
> some kind of TLB flush here?

Oh! Yes.
Perhaps, TLB flush is needed here.

Thank you,
Nobuhiko Yoshida
