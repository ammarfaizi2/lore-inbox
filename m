Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWJEVy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWJEVy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWJEVy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:54:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37323 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932303AbWJEVy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:54:57 -0400
Date: Thu, 5 Oct 2006 17:54:21 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-ID: <20061005215421.GH20551@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org> <m1vemzbe4c.fsf@ebiederm.dsl.xmission.com> <20061004214403.e7d9f23b.akpm@osdl.org> <m1ejtnb893.fsf@ebiederm.dsl.xmission.com> <20061004233137.97451b73.akpm@osdl.org> <m1vemz9s2d.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vemz9s2d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 12:48:10AM -0600, Eric W. Biederman wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Thu, 05 Oct 2006 00:13:12 -0600
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> >> Do things work better if you don't specify a vga=xxx mode?
> >
> > yes, without vga=0x263 it boots.
> 
> Ok.  It will take some digging but I suspect the problem is
> that video.S is using a table or a variable placed over the original
> boot sector, and expecting it to be zero initialized. 
> 
> Finding that in the pile of 2000 lines of assembly could take a
> little while.
> 
> Now at least we have something other people can try and reproduce
> this problem with.
>

I have tried it on three machines with various combinations of vga=
but no luck. Can't reproduce the problem at all. :-(

Vivek
