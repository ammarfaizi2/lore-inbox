Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTJOQwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTJOQwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:52:21 -0400
Received: from holomorphy.com ([66.224.33.161]:38016 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263619AbTJOQwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:52:20 -0400
Date: Wed, 15 Oct 2003 09:55:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031015165508.GA723@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031015013649.4aebc910.akpm@osdl.org> <1066232576.25102.1.camel@telecentrolivre>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066232576.25102.1.camel@telecentrolivre>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 01:42:56PM -0200, Luiz Capitulino wrote:
> Andrew (I again),
> Em Qua, 2003-10-15 ?s 06:36, Andrew Morton escreveu:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test7/2.6.0-test7-mm1
> getting this while umounting my /home (ext3) partition:
> # umount /dev/hda4
> Unable to handle kernel paging request at virtual address c282deac
> printing eip:
> c0164104
> 00007063
> *pte = 0282d000
> Oops: 0002 [#1]
> DEBUG_PAGEALLOC
> CPU:    0
> EIP:    0060:[generic_forget_inode+84/352]    Not tainted VLI
> EFLAGS: 00010246
> EIP is at generic_forget_inode+0x54/0x160

Okay, this one's me. I should have tried DEBUG_PAGEALLOC when testing.


-- wli
