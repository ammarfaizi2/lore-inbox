Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVHXPBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVHXPBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVHXPBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:01:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3000 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750918AbVHXPBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:01:19 -0400
Date: Wed, 24 Aug 2005 10:00:56 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] external interrupts: abstraction layer
In-Reply-To: <20050824073856.GD24513@infradead.org>
Message-ID: <20050824100026.L10701@chenjesu.americas.sgi.com>
References: <20050819161054.I87000@chenjesu.americas.sgi.com>
 <20050820094632.GC21698@infradead.org> <20050823153254.B5569@chenjesu.americas.sgi.com>
 <20050824073856.GD24513@infradead.org>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2005, Christoph Hellwig wrote:

> Sorry, the whole behaviour is complety fine.  I just don't thing the name
> and calling convention of file_to_extint_device is optimal.  It should
> take an struct inode * and be called just to_extint_device or someting.
> The above would become
> 
> 	struct extint_device *ed = to_extint_device(filp->f_dentry->d_inode);

OK, no problem, since file_to_extint_device() went away anyway.

Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
