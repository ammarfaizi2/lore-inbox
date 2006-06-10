Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWFJQnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWFJQnc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWFJQnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:43:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750743AbWFJQnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:43:31 -0400
Date: Sat, 10 Jun 2006 09:43:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.16-rc6-mm2
Message-Id: <20060610094324.21c3e081.akpm@osdl.org>
In-Reply-To: <448ADDA1.7090608@mbligh.org>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	<448ADDA1.7090608@mbligh.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 07:56:33 -0700
"Martin J. Bligh" <mbligh@mbligh.org> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
> > 
> > 
> > - Added the s390 git tree to the -mm lineup, as git-s390.patch (Martin
> >   Schwidefsky)
> > 
> > - ppc64 (on mac g5) fails to boot for me, due to changes in the powerpc tree.
> 
> Doesn't even build here.
> 
> arch/powerpc/platforms/built-in.o(.text+0x1053c): In function 
> `.scanlog_read':
> : undefined reference to `.rtas_extended_busy_delay_time'
> 
> Config:
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/p570
> or
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/power4
> 

Yes, the gremlins seems to have got at the powerpc tree.

> 
> The non-PPC64 machines seem to have done a clean run for the first time
> in a while ... yay!

That is good, thanks.
