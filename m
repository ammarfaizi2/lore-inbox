Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWE1MaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWE1MaI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 08:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWE1MaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 08:30:08 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:43947 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750748AbWE1MaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 08:30:07 -0400
Message-ID: <348819403.29527@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sun, 28 May 2006 20:30:06 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nathan Scott <nathans@sgi.com>
Cc: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/33] readahead: backward prefetching method
Message-ID: <20060528123006.GC6478@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nathan Scott <nathans@sgi.com>, Nate Diller <nate.diller@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469547.47755@ustc.edu.cn> <5c49b0ed0605261037p6a32db1fva693ea72b596f896@mail.gmail.com> <20060527052243.B349096@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060527052243.B349096@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2006 at 05:22:43AM +1000, Nathan Scott wrote:
> On Fri, May 26, 2006 at 10:37:56AM -0700, Nate Diller wrote:
> > On 5/24/06, Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> > > Readahead policy for reading backward.
> > 
> > Just curious, who actually does this?  I noticed you submitted patches
> 
> Nastran does this, and probably other FEA codes.  IIRC, iozone
> will measure this too - it is very important to some people in
> certain scientific arenas.

Thanks.

It makes sense to have a list of use cases for the
less-common-but-still-important access patterns.

Cheers,
Wu
