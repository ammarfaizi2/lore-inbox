Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUBUTLc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 14:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUBUTLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 14:11:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261604AbUBUTLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 14:11:30 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: GFS requirements (was: Non-GPL export of invalidate_mmap_range)
Date: Sat, 21 Feb 2004 14:09:13 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <20040216190927.GA2969@us.ibm.com> <200402202216.09908.phillips@arcor.de> <20040221141724.GH6280@marowsky-bree.de>
In-Reply-To: <20040221141724.GH6280@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402211409.13203.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 February 2004 09:17, Lars Marowsky-Bree wrote:
> On 2004-02-20T22:16:09, I said:
> > Each DFS is free to implement its own infrastructure, possibly involving
> > kernel extensions.
>
> Yes. Though I do reserve the right to find this highly silly, that we
> might end up with multiple hooks for clustering infrastructure in the
> kernel...

But the one true clustering infrastructure hasn't been developed yet.  The 
upcoming crop of designs need a chance to evolve before a framework is cast 
in stone.  Perhaps we will eventually end up with a generic harness, 
something like a vfs for cluster infrastructure, but in my opinion, we're far 
from being able to define that sensibly now.  It's better to implement 
exactly what a given DFS needs for the time being.

> So, how does OpenGFS/GFS achieve the communication? How does it interact
> with the infrastructure (which, I infere from your above comments, is
> meant to reside in user-space)?

It's done both ways, actually.  No new kernel hooks are used in either case.

Regards,

Daniel

