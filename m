Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUJNXob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUJNXob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268090AbUJNXnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:43:45 -0400
Received: from waste.org ([209.173.204.2]:32156 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267818AbUJNXkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:40:45 -0400
Date: Thu, 14 Oct 2004 18:40:20 -0500
From: Matt Mackall <mpm@selenic.com>
To: Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] move semaphore definitions to waitlock_types.h
Message-ID: <20041014234019.GZ5414@waste.org>
References: <Pine.LNX.4.61.0410142345020.29976@scrub.home> <20041014220554.GA14731@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014220554.GA14731@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 11:05:54PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 14, 2004 at 11:45:20PM +0200, Roman Zippel wrote:
> > 
> > This moves the definition and initializer of semaphore, rw_semaphore and
> > wait queue structures to waitlock_types.h.
> 
[...]
> But I must say I really hate this kind of separation as it makes
> the code rather hard to follow.

You do? This is essentially the same separation as putting code in .c files and
data definitions in .h files.

-- 
Mathematics is the supreme nostalgia of our time.
