Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbTETUSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTETUSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:18:50 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:43012 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261175AbTETUSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:18:49 -0400
From: Terence Ripperda <tripperda@nvidia.com>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
To: mikpe@csd.uu.se
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Date: Tue, 20 May 2003 15:31:32 -0500
From: <tripperda@nvidia.com>
Subject: Re: pat support in the kernel
Message-ID: <20030520203132.GF1050@hygelac>
References: <20030520185409.GB941@hygelac> <16074.33371.411219.528228@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16074.33371.411219.528228@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mikael,

I was unaware of the errata, I'll check into that.

Terence

On Tue, May 20, 2003 at 09:30:35PM +0200, mikpe@csd.uu.se wrote:
> Terence Ripperda <tripperda@nvidia.com>, <tripperda@nvidia.com> writes:
>  > Hello all,
>  > 
>  > I've discussed adding Page Attribute Table (PAT) support to the kernel w/ a few developers offline. They were very supportive and suggested I bring the discussion to lkml so others could get involved.
> 
> Not that I disagre with utilising the PAT, but I don't see anything in this code to
> deal with the widespread PAT indexing erratum in Intel's processors. I don't have
> the errata sheets here, but it definitely affected the PIIIs and I think also some P4s.
> (Large pages ignoring PAT index bit 2, or something like that.)
> 
> /Mikael
