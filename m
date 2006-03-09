Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWCIDoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWCIDoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWCIDoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:44:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:11994 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751274AbWCIDoj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:44:39 -0500
Date: Thu, 9 Mar 2006 03:44:35 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Peterson <dsp@llnl.gov>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060309034435.GQ27946@ftp.linux.org.uk>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061301.37923.dsp@llnl.gov> <1141679261.5568.13.camel@laptopd505.fenrus.org> <200603081919.59763.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603081919.59763.dsp@llnl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 07:19:59PM -0800, Dave Peterson wrote:
> I'm not familiar with the internals of the module unloading code.
> However, my understanding of the discussion so far is that the kernel
> will refuse to unload a module while any of its kobjects still have
> nonzero reference counts (either by waiting for the reference counts
> to hit 0 or returning -EBUSY).
> 
> If this is the case,

... the world you are living in is drastically different from the one
where the rest of us lives.
