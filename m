Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVJNTP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVJNTP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVJNTP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:15:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:2181 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750893AbVJNTP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:15:26 -0400
Date: Fri, 14 Oct 2005 14:14:55 -0500
From: Robin Holt <holt@sgi.com>
To: Jack Steiner <steiner@sgi.com>
Cc: Robin Holt <holt@sgi.com>, linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, jgarzik@pobox.com,
       wli@holomorphy.com
Subject: Re: [Patch 2/2] Special Memory (mspec) driver.
Message-ID: <20051014191455.GA14418@lnx-holt.americas.sgi.com>
References: <20051012194022.GE17458@lnx-holt.americas.sgi.com> <20051012194233.GG17458@lnx-holt.americas.sgi.com> <20051012202925.GA23081@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051012202925.GA23081@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 03:29:25PM -0500, Jack Steiner wrote:
> On Wed, Oct 12, 2005 at 02:42:33PM -0500, Robin Holt wrote:
> > Introduce the special memory (mspec) driver.  This is used to allow
> > userland to map fetchop, etc pages
> > 
> > Signed-off-by: holt@sgi.com
> 
> Robin - 
> 
> I think you are missing the shub2 code that is required for flushing the fetchop 
> cache. The cache is new in shub2. Take a look at the old PP4 driver - clear_mspec_page();

Done.  Will test when I get access to a shub2 machine.

Robin
