Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVDMNqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVDMNqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVDMNqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:46:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:526
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261266AbVDMNqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:46:36 -0400
Date: Wed, 13 Apr 2005 15:47:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Noah Meyerhans <noahm@csail.mit.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-ID: <20050413134740.GS1521@opteron.random>
References: <20050315204413.GF20253@csail.mit.edu> <20050315154608.29cee352.akpm@osdl.org> <20050318161217.GH642@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318161217.GH642@csail.mit.edu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 11:12:18AM -0500, Noah Meyerhans wrote:
> Well, that's certainly an interesting question.  The filesystem is IBM's
> JFS.  If you tell me that's part of the problem, I'm not likely to
> disagree.  8^)

It would be nice if you could reproduce with ext3 or reiserfs (if with
ext3, after applying the memleak fix from Andrew that was found in this
same thread ;). The below make it look like a jfs problem.

830696 830639  99%    0.80K 207674        4    830696K jfs_ip
