Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbUKDRND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbUKDRND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbUKDRNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:13:02 -0500
Received: from cantor.suse.de ([195.135.220.2]:22920 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262306AbUKDRGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:06:41 -0500
Date: Thu, 4 Nov 2004 18:04:35 +0100
From: Andi Kleen <ak@suse.de>
To: Erich Focht <efocht@hpce.nec.com>
Cc: Jack Steiner <steiner@sgi.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041104170435.GA19687@wotan.suse.de>
References: <20041103205655.GA5084@sgi.com> <20041104.105908.18574694.t-kochi@bq.jp.nec.com> <20041104141337.GA18445@sgi.com> <200411041631.42627.efocht@hpce.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411041631.42627.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:31:42PM +0100, Erich Focht wrote:
> On Thursday 04 November 2004 15:13, Jack Steiner wrote:
> > I think it would also be useful to have a similar cpu-to-cpu distance
> > metric:
> > ????????% cat /sys/devices/system/cpu/cpu0/distance
> > ????????10 20 40 60 
> > 
> > This gives the same information but is cpu-centric rather than
> > node centric.
> 
> I don't see the use of that once you have some way to find the logical
> CPU to node number mapping. The "node distances" are meant to be

I think he wants it just to have a more convenient interface,
which is not necessarily a bad thing.  But then one could put the 
convenience into libnuma anyways.

-Andi
