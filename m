Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTIUODm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 10:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbTIUODm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 10:03:42 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20379
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262412AbTIUODm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 10:03:42 -0400
Date: Sun, 21 Sep 2003 16:04:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: A couple of 2.4.23-pre4 VM nits
Message-ID: <20030921140404.GA16399@velociraptor.random>
References: <20030921024649.GB16294@velociraptor.random> <20030921053209.45935.qmail@web12803.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921053209.45935.qmail@web12803.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20, 2003 at 10:32:09PM -0700, Shantanu Goel wrote:
> Agreed on all counts.  I just blindly copied the
> max_scan decrement from 2.4.22.  Even there your
> suggestion would make sense.  Attached is a new patch
> which adds support for vm_vfs_scan_interval sysctl and
> also fixes the location of max_scan decrement.

this patch looks fine to me thanks. Marcelo, feel free to merge this one
instead of my one liner fix.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
