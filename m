Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUC3XUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUC3XR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:17:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:29119 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261576AbUC3XQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:16:36 -0500
Date: Tue, 30 Mar 2004 15:16:28 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@digeo.com>, davidm@hpl.hp.com,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: replace MAX_MAP_COUNT with /proc/sys/vm/max_map_count
Message-ID: <20040330151628.V22989@build.pdx.osdl.net>
References: <16485.5722.591616.846576@napali.hpl.hp.com> <20040326221731.54772019.akpm@digeo.com> <1080567765.18373.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1080567765.18373.33.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Mon, Mar 29, 2004 at 08:42:45AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> commit constraints.  Unless you envision introducing a different
> max_map_count for privileged processes, I'm not sure it is worthwhile to
> introduce a hook for the map_count check or to export this symbol to
> modules.  I've cc'd the LSM maintainer as well to see if he has a
> different view.

I agree with this.  BTW, am I missing an obvious reason the check
in split_vma is >= MAX_MAP_COUNT where the other two are simply >
MAX_MAP_COUNT?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
