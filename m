Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVCJJBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVCJJBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVCJJBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:01:12 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:64484 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262456AbVCJJBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:01:01 -0500
Date: Thu, 10 Mar 2005 01:00:58 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jason Luo <abcd.bpmf@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can I get 200M contiguous physical memory?
Message-ID: <20050310090058.GB29516@taniwha.stupidest.org>
References: <c4b38ec4050310001061c62b9d@mail.gmail.com> <20050310081634.GA29516@taniwha.stupidest.org> <c4b38ec40503100049190d5498@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b38ec40503100049190d5498@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 04:49:20PM +0800, Jason Luo wrote:

> A data acquisition card. In DMA mode, the card need 200M contiguous
> memory for DMA.

ick? it can't do scatter-gather or anything sane?

> it's driver in windows can do it.

windows can get 200MB of memory on a running system relaibly?  does it
swap like mad when you do this?

> so custom ask us to support it.  are there a way although it'is
> unpopular?

you could allocate the memory at boot-time just for the driver, hacky
but would work

there are a couple of patches/methods for doing this.  i think a
search for bigphysarea on google might help?

