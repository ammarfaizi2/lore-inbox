Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTGKO0H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTGKOZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:25:16 -0400
Received: from angband.namesys.com ([212.16.7.85]:53643 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261245AbTGKOXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:23:19 -0400
Date: Fri, 11 Jul 2003 18:37:56 +0400
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711143756.GC24682@namesys.com>
References: <20030711140219.GB16433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711140219.GB16433@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jul 11, 2003 at 03:02:19PM +0100, Dave Jones wrote:

> Reiserfs.
> ~~~~~~~~~
> - Reiserfs now supports inode attributes such as immutable.

This was included into 2.4.17, I think, so this is not exactly new feature.
On the real new features list we have:
 - Relocated/nonstandard size journal support (actually was included in 2.4.22-pre3, too)
 - Support for writes larger than 4k in size (get speedup on large file writes, esp. in append mode,
                                              should be more SMP friendly, too)
 - Variable blocksize support (i.e. you can choose any blocksize in range of 1024 .. PAGE_CACHE_SIZE, must be power of 2)

Bye,
    Oleg
