Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVAET0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVAET0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVAETZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:25:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:1453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262569AbVAETY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:24:57 -0500
Date: Wed, 5 Jan 2005 11:24:46 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
Message-ID: <20050105112446.X2357@build.pdx.osdl.net>
References: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com> <20050105163046.GA2060@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050105163046.GA2060@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Wed, Jan 05, 2005 at 10:30:46AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Attached is a new version of the patch introducing the __vm_enough_memory
> helper, which takes into account yesterday's suggestions.  The selinux/hooks.c
> typo was definately a dangerous bug, and __vm_enough_memory() has been moved
> to vm_enough_memory()'s original location in mm/mmap.c.

Looks alright.

> Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Signed-off-by: Chris Wright <chrisw@osdl.org>

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
