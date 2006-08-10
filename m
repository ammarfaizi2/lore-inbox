Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWHJJsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWHJJsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWHJJsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:48:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161098AbWHJJsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:48:36 -0400
Date: Thu, 10 Aug 2006 02:48:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alex Tomas <alex@clusterfs.com>
Cc: cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-Id: <20060810024816.9d83c944.akpm@osdl.org>
In-Reply-To: <m37j1hlyzv.fsf@bzzz.home.net>
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org>
	<m37j1hlyzv.fsf@bzzz.home.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 13:29:56 +0400
Alex Tomas <alex@clusterfs.com> wrote:

>  AM> - The code is very poorly commented.  I'd want to spend a lot of time
>  AM>   reviewing this implementation, but not in its present state.  
> 
> what sort of comments are you expecting?

Ones which tell me what the code is attempting to do.  Ones which tell me
the things which I need to know and which I cannot determine from the
implementation within a reasonable period of time.  Ones which tell me
about the hidden design decisions, the known shortcomings, the
things-still-to-do.

It's a bit of an artform, really.  I guess one needs to put oneself in the
position of the reader, then work out what the reader wants to know.

Good examples don't immediately leap to mind, I'm afraid.  Maybe some of
fs/buffer.c?  That's important and pretty tricky code in there, so it goes
to some lengths.

