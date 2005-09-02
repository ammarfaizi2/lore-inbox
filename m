Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVIBSY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVIBSY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVIBSY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:24:56 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:47025 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750730AbVIBSYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:24:55 -0400
Date: Fri, 2 Sep 2005 12:24:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Brent Casavant <bcasavan@sgi.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] IOCHK interface for I/O error handling/detecting (for ia64)
Message-ID: <20050902182453.GB28254@parisc-linux.org>
References: <431694DB.90400@jp.fujitsu.com> <20050901172917.I10072@chenjesu.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901172917.I10072@chenjesu.americas.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 05:45:54PM -0500, Brent Casavant wrote:
> I am extremely concerned about the performance implications of this
> implementation.  These changes have several deleterious effects on I/O
> performance.

I agree.  I think the iochk patches should be abandoned and the feature
reimplemented on top of the asynchronous PCI error notification patches
from Linas Vepstas.
