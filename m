Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVIAKk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVIAKk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 06:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVIAKk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 06:40:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20425 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964783AbVIAKk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 06:40:26 -0400
Date: Thu, 1 Sep 2005 18:46:20 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: GFS, what's remaining
Message-ID: <20050901104620.GA22482@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is the latest set of gfs patches, it includes some minor munging
since the previous set.  Andrew, could this be added to -mm? there's not
much in the way of pending changes.

http://redhat.com/~teigland/gfs2/20050901/gfs2-full.patch
http://redhat.com/~teigland/gfs2/20050901/broken-out/

I'd like to get a list of specific things remaining for merging.  I
believe we've responded to everything from earlier reviews, they were very
helpful and more would be excellent.  The list begins with one item from
before that's still pending:

- Adapt the vfs so gfs (and other cfs's) don't need to walk vma lists.
  [cf. ops_file.c:walk_vm(), gfs works fine as is, but some don't like it.]
...

Thanks
Dave

