Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUGHIVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUGHIVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 04:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUGHIVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 04:21:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:8100 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265909AbUGHIVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 04:21:31 -0400
Date: Thu, 8 Jul 2004 01:20:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-Id: <20040708012005.6232a781.akpm@osdl.org>
In-Reply-To: <m2fz82hq8c.fsf@telia.com>
References: <m2brir9t6d.fsf@telia.com>
	<40ECADF8.7010207@yahoo.com.au>
	<m2fz82hq8c.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> Nick Piggin <nickpiggin@yahoo.com.au> writes:
> 
> > Peter Osterlund wrote:
> > > I created a test program that allocates a 300MB buffer and writes to
> > > all bytes sequentially. On my computer, which has 256MB RAM and 512MB
> > > swap, the program gets OOM killed after dirtying about 140-180MB, and
> > > the kernel reports:
> > >
> > 
> > Someone hand me a paper bag... Peter, can you give this patch a try?
> 
> Doesn't help. My test program still fails in the same way.
> 

Something odd is happening - I've run that testcase in various shapes and
forms a huge number of times.

What filesystems are in use?  Is there anything unusual about the setup? 
Do earlier 2.6 kernels exhibit the same problem?  Is something wrong with
the disk system?

