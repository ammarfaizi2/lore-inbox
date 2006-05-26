Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWEZTXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWEZTXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWEZTXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:23:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47777 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751306AbWEZTXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:23:14 -0400
Date: Sat, 27 May 2006 05:22:43 +1000
From: Nathan Scott <nathans@sgi.com>
To: Nate Diller <nate.diller@gmail.com>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/33] readahead: backward prefetching method
Message-ID: <20060527052243.B349096@wobbly.melbourne.sgi.com>
References: <20060524111246.420010595@localhost.localdomain> <348469547.47755@ustc.edu.cn> <5c49b0ed0605261037p6a32db1fva693ea72b596f896@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5c49b0ed0605261037p6a32db1fva693ea72b596f896@mail.gmail.com>; from nate.diller@gmail.com on Fri, May 26, 2006 at 10:37:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:37:56AM -0700, Nate Diller wrote:
> On 5/24/06, Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> > Readahead policy for reading backward.
> 
> Just curious, who actually does this?  I noticed you submitted patches

Nastran does this, and probably other FEA codes.  IIRC, iozone
will measure this too - it is very important to some people in
certain scientific arenas.

cheers.

-- 
Nathan
