Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUBWF3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbUBWF3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:29:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:22186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261812AbUBWF3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:29:42 -0500
Date: Sun, 22 Feb 2004 21:30:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: P.Luptak@sh.cvut.cz, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: SW RAID5 + high memory support freezes 2.6.3 kernel
Message-Id: <20040222213011.7e1b8bbf.akpm@osdl.org>
In-Reply-To: <16441.33071.218049.163976@notabene.cse.unsw.edu.au>
References: <20040223024124.GA1590@psilocybus>
	<16441.33071.218049.163976@notabene.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> > Hello,
>  > issue http://www.spinics.net/lists/lvm/msg10322.html could be still present
>  > in the current 2.6.3 kernel. I am able to repeat the conditions to halt the 
>  > 2.6.3 kernel (using mkfs.ext3 on RAID device):
> 
>  To be fair, your subject should say that 
>     SW RAID5 + high memory + loop device freezes 2.6.3 kernel
>                            ^^^^^^^^^^^^^^

hm, yes.  And the loop code which was involved here was removed from the
kernel last week, so it's a bit academic.

Retest on current 2.6.3-bk or 2.6.3-mm3 please.
