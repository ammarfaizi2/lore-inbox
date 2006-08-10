Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbWHJKHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWHJKHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 06:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWHJKHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 06:07:10 -0400
Received: from [80.71.248.82] ([80.71.248.82]:50882 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1161137AbWHJKHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 06:07:09 -0400
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@osdl.org>
Cc: Alex Tomas <alex@clusterfs.com>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org> <m37j1hlyzv.fsf@bzzz.home.net>
	<20060810024816.9d83c944.akpm@osdl.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Thu, 10 Aug 2006 14:08:49 +0400
In-Reply-To: <20060810024816.9d83c944.akpm@osdl.org> (Andrew Morton's message of "Thu, 10 Aug 2006 02:48:16 -0700")
Message-ID: <m3u04klx72.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


just to make things clear ... I thought the code isn't that bad commented. I may be wrong, of course. but could you have a look at few routines
(ext3_ext_create_new_leaf() or ext3_ext_get_blocks() fo example)
and tell me what's wrong with existing comments (besides monkey english)
and how it should look like?

thanks, Alex

>>>>> Andrew Morton (AM) writes:

 AM> On Thu, 10 Aug 2006 13:29:56 +0400
 AM> Alex Tomas <alex@clusterfs.com> wrote:

 AM> - The code is very poorly commented.  I'd want to spend a lot of time
 AM> reviewing this implementation, but not in its present state.  
 >> 
 >> what sort of comments are you expecting?

 AM> Ones which tell me what the code is attempting to do.  Ones which tell me
 AM> the things which I need to know and which I cannot determine from the
 AM> implementation within a reasonable period of time.  Ones which tell me
 AM> about the hidden design decisions, the known shortcomings, the
 AM> things-still-to-do.

 AM> It's a bit of an artform, really.  I guess one needs to put oneself in the
 AM> position of the reader, then work out what the reader wants to know.

 AM> Good examples don't immediately leap to mind, I'm afraid.  Maybe some of
 AM> fs/buffer.c?  That's important and pretty tricky code in there, so it goes
 AM> to some lengths.
