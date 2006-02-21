Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbWBULy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbWBULy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWBULy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:54:57 -0500
Received: from linuxhacker.ru ([217.76.32.60]:6040 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S932709AbWBULy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:54:56 -0500
Date: Tue, 21 Feb 2006 13:56:16 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060221115616.GG5733@linuxhacker.ru>
References: <20060220221948.GC5733@linuxhacker.ru> <20060220215122.7aa8bbe5.akpm@osdl.org> <20060221113055.GF5733@linuxhacker.ru> <20060221033605.1518ceab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221033605.1518ceab.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Feb 21, 2006 at 03:36:05AM -0800, Andrew Morton wrote:
> >   Introduce FMODE_EXEC file flag, to indicate that file is being opened for
> >    execution. This is useful for distributed filesystems to maintain consistent
> >    behavior for returning ETXTBUSY when opening for write and execution
> >    happens on different nodes.
> You forgot something.
> Are other clustered/distributed filesystems likely to need something like
> this and if so, is this implementation sufficient for their purposes?

No, I did not.
I CCed fsdevel originally in part because other clustered/distributed
filesystems developers are likely to read lkml or fsdevel and might share their
opinions about the patch and the approach itself.
Actually I am not sure if any other non-local filesystem tries to be as close
to local fs in semantic as Lustre does.

Bye,
    Oleg
