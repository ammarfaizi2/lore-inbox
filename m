Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUBTP2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbUBTP2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:28:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14500 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261289AbUBTP2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:28:42 -0500
Date: Fri, 20 Feb 2004 15:31:45 +0000
From: Joe Thornber <thornber@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>, thornber@redhat.com
Subject: device-mapper patchset
Message-ID: <20040220153145.GN27549@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's another device mapper update, some of these are quite big
patches, so I'll run through the list:

endio method
  We've been using this code for many months (years?).  Needed for the
  more complicated targets.

Remove the version-1 ioctl interface
  This didn't get in last time I submitted it.  Leave it out if you
  still disagree.

Audit for list_for_each_*entry*
  Trivial, please merge

Queue limits
  Please merge.

List targets ioctl
  Adds a command that lets tools query the kernel to see what
  targets/versions are available.

Multipath target
  People really want this, so I'm probably pushing it sooner than I'd
  like.  It would be good if it got a wider audience in the -mm tree or
  as an experimental target in vanilla.

Thanks,

- Joe
