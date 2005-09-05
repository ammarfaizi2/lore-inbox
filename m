Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVIEJNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVIEJNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVIEJNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:13:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932355AbVIEJNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:13:09 -0400
Date: Mon, 5 Sep 2005 17:18:47 +0800
From: David Teigland <teigland@redhat.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Greg KH <greg@kroah.com>, arjan@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050905091847.GD17607@redhat.com>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org> <20050902094403.GD16595@redhat.com> <20050903052821.GA23711@kroah.com> <20050905034739.GA11337@redhat.com> <20050905085808.GA22802@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905085808.GA22802@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 10:58:08AM +0200, J?rn Engel wrote:

> #define gfs2_assert(sdp, assertion) do {			\
> 	if (unlikely(!(assertion))) {				\
> 	printk(KERN_ERR "GFS2: fsid=\n", (sdp)->sd_fsname);	\
> 	BUG();							\
> } while (0)

OK thanks,
Dave

