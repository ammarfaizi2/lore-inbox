Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWIBJmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWIBJmt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 05:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWIBJms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 05:42:48 -0400
Received: from ns1.suse.de ([195.135.220.2]:25289 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750926AbWIBJms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 05:42:48 -0400
Date: Sat, 2 Sep 2006 02:42:39 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@suse.de>,
       andrew@digital-domain.net
Subject: Re: [Bugme-new] [Bug 7065] New: Devices no longer automount
Message-ID: <20060902094239.GH26849@kroah.com>
References: <200608281700.k7SH0CYl013187@fire-2.osdl.org> <20060828121057.035fd690.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828121057.035fd690.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 12:10:57PM -0700, Andrew Morton wrote:
> On Mon, 28 Aug 2006 10:00:12 -0700
> bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=7065
> > 
> >            Summary: Devices no longer automount
> 
> A post-2.6.17 regression, nicely bisected down to a particular changeset
> (thanks!).
> 
> Is anyone else hitting this?
> 
> 
> >     Kernel Version: 2.6.18-rc5
> >             Status: NEW
> >           Severity: normal
> >              Owner: other_other@kernel-bugs.osdl.org
> >          Submitter: andrew@digital-domain.net

This was narrowed down to a broken userspace configuration by the
freedesktop.org developers.

Many thanks to them.

So no kernel issue here.

thanks,

greg k-h

-- 
VGER BF report: U 0.46418
