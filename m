Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUKVUeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUKVUeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbUKVUbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:31:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:40603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262504AbUKVUaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:30:18 -0500
Date: Mon, 22 Nov 2004 12:30:00 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
Message-ID: <20041122123000.C14339@build.pdx.osdl.net>
References: <20041121001318.GC979@locomotive.unixthugs.org> <1101145050.18273.68.camel@moss-spartans.epoch.ncsc.mil> <41A22A2D.1000708@suse.com> <1101148090.18273.94.camel@moss-spartans.epoch.ncsc.mil> <41A23922.80501@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41A23922.80501@suse.com>; from jeffm@suse.com on Mon, Nov 22, 2004 at 02:08:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Mahoney (jeffm@suse.com) wrote:
> Excellent. Thanks. Preliminary testing works as expected (ie: deadlocks
> don't occur, xattrs/<dir> is removed when owning file is deleted)
> 
> I've integrated the changes into my patch set. With those issues
> addressed, would you feel these would be appropriate for inclusion? I
> suspect you may have gotten questions as many interested parties in this
> feature working as I have.

Why add extra hook, when this could be done in VFS with i_flags?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
