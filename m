Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbTJXAec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTJXAec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:34:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6866 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261735AbTJXAeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:34:31 -0400
Date: Fri, 24 Oct 2003 02:34:28 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, daniel@osdl.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIOtestingon2.6.0-test7-mm1)
Message-ID: <20031024003427.GK21490@fs.tum.de>
References: <1066693673.22983.10.camel@ibm-c.pdx.osdl.net> <20031021121113.GA4282@in.ibm.com> <1066869631.1963.46.camel@ibm-c.pdx.osdl.net> <20031023104923.GA11543@in.ibm.com> <20031023135030.GA11807@in.ibm.com> <20031023155937.41b0eeda.akpm@osdl.org> <20031023232006.GH21490@fs.tum.de> <20031023162539.0051249d.akpm@osdl.org> <20031023233700.GJ21490@fs.tum.de> <20031023164638.5c32b80f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023164638.5c32b80f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 04:46:38PM -0700, Andrew Morton wrote:
>...
> > -Os has it's benefits on some systems, so it shouldn't be totally hidden 
> > under EMBEDDED. OTOH, it's less tested, so only people who know what 
> > they are doing should use it (EXPERIMENTAL plus help text).
> 
> It causes kernels to crash on a major linux distribution.  We need to
> either make it very hard to turn on, or just forget it altogether.

Looking at the source RPM, it seems e.g. gcc bug #8746 "gcc miscompiles
Linux kernel ppa driver on x86" (fixed in gcc 3.2.3) is also unfixed in
the gcc in RedHat 9.0 ...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

