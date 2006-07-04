Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWGDPIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWGDPIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWGDPIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:08:14 -0400
Received: from a34-mta02.direcpc.com ([66.82.4.91]:22753 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S932150AbWGDPIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:08:14 -0400
Date: Tue, 04 Jul 2006 11:06:56 -0400
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [Ubuntu PATCH] fix VFS nr_files accounting
In-reply-to: <20060703235031.0fe17c18.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org,
       viro@zeniv.linux.org.uk
Message-id: <1152025616.23756.93.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <44A98241.2040705@oracle.com>
 <20060703235031.0fe17c18.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 23:50 -0700, Andrew Morton wrote:
> On Mon, 03 Jul 2006 13:46:57 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
> > 
> > lkml discussion: http://thread.gmane.org/gmane.linux.kernel/385438/focus=385478
> > 
> > Already in -mm?
> > 
> > From: Dipankar Sarma <dipankar@in.ibm.com>
> > 
> > Ubuntu patch location:
> > http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=5ce2ed3a63172c6ce0b97069e449960c2d538623
> > 
> 
> hm.  This is actually a reversion of
> 529bf6be5c04f2e869d07bfdb122e9fd98ade714, so it presumably reintroduces the
> problem discussed in that lkml thread.
> 
> Ben, what's the story here?

This was pulled in to try to fix some problems we were seeing on
sparc64. However, this backported patch broke other architectures (I
think x86_64 wouldn't even boot), so was reverted.

I can't remember any more details than that.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

