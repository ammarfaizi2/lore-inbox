Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVKWRWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVKWRWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVKWRWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:22:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:35214 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751259AbVKWRWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:22:39 -0500
Date: Wed, 23 Nov 2005 09:10:41 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
Message-ID: <20051123171041.GC26149@kroah.com>
References: <1132715288.26560.262.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132715288.26560.262.camel@gaston>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 02:08:07PM +1100, Benjamin Herrenschmidt wrote:
> This patch applies on top of the patch that moves the PowerMac specific
> code out of ohci-pci.c to hcd-pci.c where it belongs. This patch isn't
> upstream yet for reasons I don't fully understand (why does USB stuffs
> has such a high latency for going upstream ?), I'm sending it as a reply
> to this email for completeness.

Sorry, I hadn't seen it, otherwise I would have sent it on.

David, are you ok with the patch Ben sent on as a followup?

thanks,

greg k-h
