Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVGOPzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVGOPzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 11:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbVGOPzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 11:55:55 -0400
Received: from c-67-163-99-44.hsd1.tx.comcast.net ([67.163.99.44]:33762 "EHLO
	leaper.linuxtx.org") by vger.kernel.org with ESMTP id S261496AbVGOPzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 11:55:53 -0400
Date: Fri, 15 Jul 2005 10:53:33 -0500
From: "Justin M. Forbes" <jmforbes@linuxtx.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050715155333.GA387@linuxtx.org>
References: <20050713184130.GA9330@kroah.com> <20050713184426.GM9330@kroah.com> <20050713184946.GY23737@wotan.suse.de> <20050714094516.A1847@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714094516.A1847@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 09:45:17AM -0700, Siddha, Suresh B wrote:
> On Wed, Jul 13, 2005 at 08:49:47PM +0200, Andi Kleen wrote:
> > On Wed, Jul 13, 2005 at 11:44:26AM -0700, Greg KH wrote:
> > > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > I think the patch is too risky for stable. I had even my doubts
> > for mainline.
> 
> hmm.. Main reason why Andrew posted this for stable series is because of
> the memory leak issue mentioned in the patch changeset comments...
> 
I would say if Andi has concerns for this stable series, we should indeed
leave it out.  That said, I will be testing this patch a bit further
myself, and because it does address a real memory leak issue, we should
consider it or another fix for stable 2.6.12.4.

Justin M. Forbes
