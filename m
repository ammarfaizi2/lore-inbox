Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWJYU2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWJYU2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWJYU2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:28:41 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:30935 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1161185AbWJYU2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:28:40 -0400
Date: Wed, 25 Oct 2006 16:28:06 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: David Howells <dhowells@redhat.com>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching
Message-ID: <20061025202806.GC3854@filer.fsl.cs.sunysb.edu>
References: <16969.1161771256@redhat.com> <20061025202155.GB3854@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025202155.GB3854@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 04:21:55PM -0400, Josef Sipek wrote:
...
> I'm wondering, why don't just you duplicate all the attributes of the files
> (including xattrs)? That would take care of most if not all the DAC/MAC
> issues, no?

By that I mean issues associated with accessing the cache, not creating the
cache copies.

Josef "Jeff" Sipek.

-- 
Note 96.3% of all statistics are fiction.
