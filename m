Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUCAPU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 10:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUCAPU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 10:20:59 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:36764 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261317AbUCAPU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 10:20:57 -0500
Date: Mon, 1 Mar 2004 10:20:46 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: David Luyer <david@luyer.net>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Subject: Re: Linux 2.4.25-rc1
In-Reply-To: <Pine.LNX.4.44.0403011209200.4148-100000@dmt.cyclades>
Message-ID: <Pine.LNX.4.44.0403011020190.21897-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004, Marcelo Tosatti wrote:

> > We just had a box which crashed only 2 hour from deployment, and
> > reading over the recent changes this seems like a potential cause
> > (although being new, faulty hardware is always a possibility); the
> > last items on its serial console were:
> > 
> > INIT: Sending processes the TERM signal
> > memory.c:100: bad pmd 000001e3.
> > memory.c
> 
> This looks like hardware fault to me or a (maybe, not sure) badly
> behaving driver. The inode-highmem modifications can't cause such
> breakage, as far as I can see.

Agreed, this looks like a hardware fault.


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

