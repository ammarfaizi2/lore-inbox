Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTJIU1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTJIU1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:27:34 -0400
Received: from intra.cyclades.com ([64.186.161.6]:25006 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262409AbTJIU1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:27:32 -0400
Date: Thu, 9 Oct 2003 17:25:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.x performance tests Re: [PATCH] BUG() in exec_mmap()
In-Reply-To: <Pine.LNX.4.44.0310091718080.3040-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0310091724060.3040-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Oct 2003, Marcelo Tosatti wrote:

> 
> 
> On Thu, 9 Oct 2003, Dave Kleikamp wrote:
> 
> > Marcelo,
> > A recent change to exec_mmap() removed the initialization of old_mm,
> > leaving an uninitialized use of it.  This patch would completely remove
> > old_mm from the function.  Is this what was intended?
> 
> Yes. 
> 
> Blame me... patch applied, thank you!

BTW, further performance testing of the removal of this optimization is 
VERY welcome.

I've done some tests and no big performance harm has showed up, but thats 
just me.


