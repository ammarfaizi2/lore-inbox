Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVKJIVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVKJIVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKJIVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:21:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5583 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750751AbVKJIVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:21:37 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       Jody McIntyre <scjody@modernduck.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: Re: merge status 
In-reply-to: Your message of "Thu, 10 Nov 2005 02:47:36 CDT."
             <4372FB18.90905@pobox.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Nov 2005 19:19:51 +1100
Message-ID: <11038.1131610791@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005 02:47:36 -0500, 
Jeff Garzik <jgarzik@pobox.com> wrote:
>Brown, Len wrote:
>> I do have a bundle of Linux specific bug fixes to push,
>> but I didn't follow Tony's git branching strategy
>> correctly at first,
>
>Is Tony's strategy described anywhere?

Tony's mail.

----------------------------------

Subject: change to the ia64 GIT trees
Date:	Tue, 16 Aug 2005 15:00:38 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-ia64@vger.kernel.org>
Cc: <akpm@osdl.org>

Now that GIT is smarter, and I'm more aware of what it can do
(and how to make it do it), I'm making a small change to how
I export GIT trees on kernel.org.

Instead of having separate trees for test and release, there
is now just one tree which contains "test" and "release" branches.
[or there will be soon when my deletion of the old test tree
is reflected on the kernel.org mirrors].

You can pull each of the branches separately with:

 $ git pull rsync://rsync.kernel.org/..../aegl/linux-2.6 test
or
 $ git pull rsync://rsync.kernel.org/..../aegl/linux-2.6 release

I wrote a "howto" for GIT about using branches as a Linux
subsystem maintainer that was included in the GIT sources
yesterday.  You can read a copy at http://tinyurl.com/d57dc

----------------------------------

