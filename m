Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVCDIzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVCDIzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVCDIzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:55:32 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:32952 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262670AbVCDIzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:55:21 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 4 Mar 2005 09:51:50 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 vs DVB cx88 stuffs
Message-ID: <20050304085150.GB6647@bytesex>
References: <200503032119.04675.gene.heskett@verizon.net> <20050303224438.2952f63e.akpm@osdl.org> <20050303231716.14a48f5f.akpm@osdl.org> <20050304073917.GA1496@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304073917.GA1496@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:39:17AM -0500, Dave Jones wrote:
> On Thu, Mar 03, 2005 at 11:17:16PM -0800, Andrew Morton wrote:
> 
>  > >  The reason this wasn't picked up is that neither `make allyesconfig' or
>  > >  `make allmodconfig' enables CONFIG_VIDEO_CX88_DVB or
>  > >  CONFIG_VIDEO_CX88_DVB_MODULE.
>  > >
>  > >  For coverage purposes it would be excellent to fix that up too, please.
>  > 
>  > Wise words, those.
> 
> It's dependant on CONFIG_BROKEN. Remove that, and allmodconfig should pick it up.

It's tagged broken _because_ it doesn't build yet.  I've patches in the
queue, they depend on some dvb updates through, and I'm bugging the
linuxtv guys at the moment to push updates, so I can submit my stuff as
well.  The build failure and the CONFIG_BROKEN will go away then.

There is no point in fixing the build now somehow because that wouldn't
make the driver actually work ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
