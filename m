Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263225AbUJ2K0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUJ2K0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUJ2K0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:26:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:64236 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263225AbUJ2K0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:26:24 -0400
Date: Fri, 29 Oct 2004 03:24:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-Id: <20041029032420.327d65dd.akpm@osdl.org>
In-Reply-To: <20041029101758.GA7278@atrey.karlin.mff.cuni.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
	<20041029024651.1ebadf82.akpm@osdl.org>
	<20041029101758.GA7278@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
> > Jan Kara <jack@suse.cz> wrote:
>  > >
>  > >    I know about a few people who would like to use some functionality of
>  > >  the Magic Sysrq but don't want to enable all the functions it provides.
>  > 
>  > That's a new one.  Can you tell us more about why people want to do such a
>  > thing?
>    For example in a computer lab at the university the admin don't want
>  to allow users to Umount/Kill (mainly to make it harder for users to
>  screw up the computer) but wants to allow SAK/Unraw.
>    Another (actually not so legitimate ;) example is that in e.g. SUSE
>  kernels sysrq is turned off by default (some people are afraid that it
>  could be a security issue) so most users have it turned off and hence
>  when the computer deadlocks, there's no debugging output.

OK, fair enough.  I'll merge the patch if you talk suse into enabling
sysrq-T and sysrq-P and sysrq-M by default ;)
