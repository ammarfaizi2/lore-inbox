Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVITVMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVITVMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbVITVMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:12:09 -0400
Received: from thunk.org ([69.25.196.29]:24774 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965127AbVITVMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:12:08 -0400
Date: Tue, 20 Sep 2005 17:11:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jonathan Briggs <jbriggs@esoft.com>
Cc: David Masover <ninja@slaphack.com>, Pavel Machek <pavel@suse.cz>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050920211136.GA6179@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jonathan Briggs <jbriggs@esoft.com>,
	David Masover <ninja@slaphack.com>, Pavel Machek <pavel@suse.cz>,
	Hans Reiser <reiser@namesys.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
	Christoph Hellwig <hch@infradead.org>,
	Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <43301FA0.7030906@slaphack.com> <20050920175727.GA17820@thunk.org> <1127240326.10407.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127240326.10407.22.camel@localhost>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:18:46PM -0600, Jonathan Briggs wrote:
> 
> I use Reiser3 and Reiser4 on all my systems and fsck has always worked
> even if it has been much slower than I would like.  The only problems
> I've experienced have been on the same level as when an ext2/3
> filesystem fsck dumps several directories of unlabeled files into lost
> +found.

You've obviously never kept several dozen reiserfs filesystem images
(for use with Xen or User-Mode Linux) on a reiserfs filesystem, and
then had a hardware failure bad enough that the fsck had to try to
rebuild the b-tree, I take it?

						- Ted
