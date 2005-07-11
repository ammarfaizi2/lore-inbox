Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVGKR2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVGKR2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVGKR0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:26:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261941AbVGKR0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:26:02 -0400
Date: Mon, 11 Jul 2005 10:25:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Chris Wright <chrisw@osdl.org>, Robert Love <rml@novell.com>,
       ttb@tentacle.dhs.org, linux-audit@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] fsnotify
Message-ID: <20050711172536.GI19052@shell0.pdx.osdl.net>
References: <20050709012436.GD19052@shell0.pdx.osdl.net> <20050709012657.GE19052@shell0.pdx.osdl.net> <1121086366.27264.108.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121086366.27264.108.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Woodhouse (dwmw2@infradead.org) wrote:
> What would make sense, perhaps, would be to actually merge those hooks;
> not just a cosmetic amalgamation of the calling sites. Currently, each
> of inotify and the audit code does its own filtering when its hooks are
> triggered, and then acts upon the event only if it affects a watched
> inode. 

That's exactly what my intention was by posting this.  The hook site is
just enough to get the conversation going.  The really useful bits to
merge are at inode watch level.

thanks,
-chris
