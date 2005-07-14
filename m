Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVGNQqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVGNQqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVGNQqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:46:39 -0400
Received: from fmr21.intel.com ([143.183.121.13]:9394 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261562AbVGNQqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:46:38 -0400
Date: Thu, 14 Jul 2005 09:45:17 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050714094516.A1847@unix-os.sc.intel.com>
References: <20050713184130.GA9330@kroah.com> <20050713184426.GM9330@kroah.com> <20050713184946.GY23737@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050713184946.GY23737@wotan.suse.de>; from ak@suse.de on Wed, Jul 13, 2005 at 08:49:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 08:49:47PM +0200, Andi Kleen wrote:
> On Wed, Jul 13, 2005 at 11:44:26AM -0700, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> 
> I think the patch is too risky for stable. I had even my doubts
> for mainline.

hmm.. Main reason why Andrew posted this for stable series is because of
the memory leak issue mentioned in the patch changeset comments...

We have not seen any stability issues because of this patch so far(its been
there for more than a month in -mm series). Lack of this patch is actually 
causing us more troubles (DOS/app failures/..).

thanks,
suresh
