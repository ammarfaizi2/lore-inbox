Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWEYSLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWEYSLD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWEYSLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:11:02 -0400
Received: from lixom.net ([66.141.50.11]:58336 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1030306AbWEYSLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:11:00 -0400
Date: Thu, 25 May 2006 11:09:52 -0700
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Message-ID: <20060525180952.GD9867@pb15.lixom.net>
References: <20060524001653.19403.31396.stgit@gitlost.site> <20060524002012.19403.50151.stgit@gitlost.site> <20060525175940.GB9867@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525175940.GB9867@pb15.lixom.net>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 10:59:40AM -0700, Olof Johansson wrote:

> Is there a specific reason for why you chose to export 3 different
> memcpu calls? They're all just wrapped to the same internals.
>
> It would seem to make sense to have the client do their own
> page_address(page) + offset calculations and just export one function?

Nevermind. I'm too used to 64-bit environments where all memory is
always addressable to the kernel. There's obvious reasons to do it on
32-bit platforms to avoid the extra kernel mapping.


-Olof
