Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbTJBCqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 22:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263218AbTJBCqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 22:46:43 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:50091 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263214AbTJBCqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 22:46:42 -0400
Date: Wed, 1 Oct 2003 22:46:36 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tim Hockin <thockin@hockin.org>, Linus Torvalds <torvalds@osdl.org>,
       Pete Zaitcev <zaitcev@redhat.com>, braam@clusterfs.com,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Many groups patch.
Message-ID: <20031001224636.A21298@devserv.devel.redhat.com>
References: <20031001184610.GA25716@hockin.org> <20031002022545.7D49D2C14D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031002022545.7D49D2C14D@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Oct 02, 2003 at 12:25:10PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Groups are sorted and b-searched for efficiency.
> 
> That's where I feel Linus' comment about catering to stupidity comes
> in 8)

I'm in this discussion for NFS groups only. The difficulty
is that NFS needs to sort groups differently, LRU by usage
(instead of numerical value). Therefore, two ways to index
that data set are unavoidable. Two b-trees, perhaps.

-- Pete
