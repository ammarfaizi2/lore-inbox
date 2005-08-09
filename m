Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVHIFhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVHIFhf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVHIFhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:37:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932448AbVHIFhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:37:34 -0400
Date: Mon, 8 Aug 2005 22:37:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: capabilities patch (v 0.1)
Message-ID: <20050809053724.GG7991@shell0.pdx.osdl.net>
References: <20050809052621.GA7970@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809052621.GA7970@clipper.ens.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Madore (david.madore@ens.fr) wrote:
> * Second, a much more extensive change, the patch introduces a third
> set of capabilities for every process, the "bounding" set.  Normally

this is not a good idea.  don't add more sets. if you really want to
work on this i'll give you all the patches that have been done thus far,
plus a set of tests that look at all the execve, ptrace, setuid type of
corner cases.

thanks,
-chris
