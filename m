Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTLXDSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 22:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTLXDSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 22:18:49 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:22236 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263082AbTLXDSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 22:18:47 -0500
Date: Tue, 23 Dec 2003 19:18:35 -0800
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ioe-lkml@rameria.de,
       shemminger@osdl.org, sylvain.jeaugey@bull.net, raybry@sgi.com,
       hch@infradead.org, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] another minor bit of cpumask cleanup
Message-Id: <20031223191835.26c974f2.pj@sgi.com>
In-Reply-To: <20031224023632.5D5462C260@lists.samba.org>
References: <20031223021039.5b99a04b.pj@sgi.com>
	<20031224023632.5D5462C260@lists.samba.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> thanks for reviewing!

My pleasure.

> Maybe Dave will be convinced: he's dogmatic, but rarely unreasonable.

On the third hand, it would be unreasonable of me to expect Dave to
agree to shoot his products performance in the foot for the sake of my
"more refined" coding style sensibilities.

> I think we'll only be able to tell with the patch in front of us.

I could publish an early version of it now, but I am supposed to be
on vacation now with my family, so should avoid starting a discussion
that I shouldn't participate in.

> Someday someone will enable VOYAGER_DEBUG and they'll fix it.

yup

> In 2.7, my aim is to switch the rest of them, move more things to
> per-cpu rather than [NR_CPUS] arrays, add the more efficient dynamic
> per-cpu allocation, and spread the per-cpu religion by fire and the
> sword.

For folks doing really large cpu counts, like my employer, this might
become of interest sooner.  On the other hand, we do really large memory
as well, so this might not be especially critical to us.

If NR_CPUS arrays start to annoy us sooner, I'll know where to consult.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
