Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbUBYMwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 07:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUBYMwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 07:52:35 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:3013 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261176AbUBYMwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 07:52:34 -0500
Date: Wed, 25 Feb 2004 07:52:32 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Grigor Gatchev <grigor@zadnik.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <Pine.LNX.4.44.0402251103470.16939-100000@lugburz.zadnik.org>
Message-ID: <Pine.LNX.4.44.0402250751140.30721-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Grigor Gatchev wrote:

> > I'm all for cleaning up the badly written code so it fits
> > in better with the rest of the kernel ;)
> 
> Unhappily, cleaning up would not be enough. A separation of the kernel
> layers, to the extent that one may be able to use them independently,
> and to plug modules between them (having the appropriate access) may be
> better.

Some parts of the kernel (eg. the VFS or the device driver
layers) can already do that, while others still have layering
violations.

I suspect that the least destabilising way of moving to a
more modular model would be to gradually clean up the layering
violations in the rest of the code, until things are modular.

Yes, I know it's a lot of work ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

