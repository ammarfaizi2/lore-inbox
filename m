Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269357AbUJKXUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269357AbUJKXUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUJKXUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:20:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52221 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269340AbUJKXTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:19:32 -0400
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041011153830.495b7c2d.akpm@osdl.org>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011214304.GD31731@wotan.suse.de>
	 <1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011221519.GA11702@wotan.suse.de>
	 <20041011153830.495b7c2d.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1097536210.12861.402.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Oct 2004 16:10:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 15:38, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > > Console: colour VGA+ 80x25
> > > Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> > > Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> > > Bad page state at free_hot_cold_page (in process 'swapper', page
> > > 000001017ac06070)
> > > flags:0x00000000 mapping:0000000000000000 mapcount:1 count:0
> > 
> > Some memory corruption or confused memory allocator.
> 
> I'd be suspecting no-buddy-bitmap-patch-*.patch
> 

Nope. This is not it..

Andi, do you know which is the last good -mm kernel on AMD ?
Is it 2.6.9-rc3-mm3 ? The last I tested on AMD was 2.6.9-rc2-mm3 :(

Thanks,
Badari

