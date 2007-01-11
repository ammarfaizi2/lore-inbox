Return-Path: <linux-kernel-owner+w=401wt.eu-S1161079AbXALLCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbXALLCi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbXALLCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:02:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2264 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161060AbXALLCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:02:38 -0500
Date: Thu, 11 Jan 2007 14:35:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: Mimi Zohar <zohar@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
Subject: Re: mprotect abuse in slim
Message-ID: <20070111143537.GB6843@ucw.cz>
References: <20070108134152.GA19811@infradead.org> <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> SLIM implements dynamic process labels, so when a process
> is demoted, we must be able to revoke write access to some
> resources to which it has previously valid handles.
> For example, if a shell reads an untrusted file, the
> shell is demoted, and write access to more trusted files
> revoked. Based on previous comments on lkml, we understand
> that this is not really possible in general, so SLIM only
> attempts to revoke access in certain simple cases.

Are you saying that SLIM is useless by design because interested
parties can work around it?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
