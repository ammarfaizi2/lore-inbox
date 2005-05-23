Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVEWRku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVEWRku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 13:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEWRjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 13:39:48 -0400
Received: from fmr22.intel.com ([143.183.121.14]:5793 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261931AbVEWRdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 13:33:14 -0400
Date: Mon, 23 May 2005 10:32:12 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, zwane@arm.linux.org.uk,
       discuss@x86-64.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       rusty@rustycorp.com.au, vatsa@in.ibm.com
Subject: Re: [patch 2/4] CPU hot-plug support for x86_64
Message-ID: <20050523103211.A8692@unix-os.sc.intel.com>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050520223417.532048000@csdlinux-2.jf.intel.com> <20050523163816.GA39821@muc.de> <20050523095816.B8193@unix-os.sc.intel.com> <20050523172424.GG39821@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050523172424.GG39821@muc.de>; from ak@muc.de on Mon, May 23, 2005 at 07:24:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 07:24:24PM +0200, Andi Kleen wrote:
> On Mon, May 23, 2005 at 09:58:17AM -0700, Ashok Raj wrote:
> > 
> > If its for documentation, then its ok, the reason i thought it will
> > be dead code/documentation soon is since 90% of the hotplug code is
> > generic kernel code, which is not under __cpuinit, just some pieces of 
> > x86_64 would alone exist this way, and will not serve real purpose very soon.
> 
> I would hope these other pieces get converted over. I will probably
> look into that soon if nobody beats me.
> 

If my IRC, this is how we got started early days. I remember rusty changed them
during the end of the real development. 

Rusty/Vatsa would know the exact scope on why we went away from __cpuinit.

[Both who's names i missed accidently in ccing, when i was trying the new
quilt mail, i exited by mistake, and it sent to the partial list, sorry guys]


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
