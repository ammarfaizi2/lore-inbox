Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUFYS5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUFYS5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUFYS5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:57:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:45031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266835AbUFYSyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:54:52 -0400
Date: Fri, 25 Jun 2004 11:53:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: cieciwa@alpha.zarz.agh.edu.pl, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: [SPARC64] kernel 2.6.7+cset-20040625_0611 = ERROR
Message-Id: <20040625115348.371dcb0b.akpm@osdl.org>
In-Reply-To: <20040625103020.25b37791.davem@redhat.com>
References: <Pine.LNX.4.58L.0406251320310.6037@alpha.zarz.agh.edu.pl>
	<20040625030502.40e25d42.akpm@osdl.org>
	<20040625103020.25b37791.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> On Fri, 25 Jun 2004 03:05:02 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl> wrote:
> > >
> > > make[1]: *** [arch/sparc64/kernel/process.o] Error 1
> > >  make: *** [arch/sparc64/kernel] Error 2
> > 
> > here's t'other:
> 
> Ok, is it only gcc-3.4 and later that spit out these warnings?
> I've been doing gcc-3.3 builds without incident... oh or maybe
> only on SMP.  I haven't tried a uniprocessor build in a while.

I'm using gcc-3.3.2, CONFIG_SMP=y and was able to reproduce the warnings.
