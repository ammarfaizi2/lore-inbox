Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWBPUY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWBPUY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWBPUY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:24:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964884AbWBPUY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:24:58 -0500
Date: Thu, 16 Feb 2006 12:18:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@sgi.com>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] Notifier chain update: API changes
Message-Id: <20060216121831.6904376c.akpm@osdl.org>
In-Reply-To: <yq0u0azxwwg.fsf@jaguar.mkp.net>
References: <Pine.LNX.4.44L0.0602101101350.5227-100000@iolanthe.rowland.org>
	<yq0u0azxwwg.fsf@jaguar.mkp.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sgi.com> wrote:
>
> >>>>> "Alan" == Alan Stern <stern@rowland.harvard.edu> writes:
> 
> Alan> The kernel's implementation of notifier chains is unsafe.  There
> Alan> is no protection against entries being added to or removed from
> Alan> a chain while the chain is in use.  The issues were discussed in
> Alan> this thread:
> 
> Alan> http://marc.theaimsgroup.com/?l=linux-kernel&m=113018709002036&w=2
> 
> Hi,
> 
> I was wondering if there was anything blocking this change from going
> in? I'd quite like to see it as it would avoid me from inventing yet
> another notifier chain implementation ;-)
> 

It's still lurking in my to-apply folder - will get onto it soon.
