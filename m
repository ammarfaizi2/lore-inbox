Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281657AbRKUHvJ>; Wed, 21 Nov 2001 02:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281659AbRKUHu7>; Wed, 21 Nov 2001 02:50:59 -0500
Received: from pc1-camc3-0-cust88.cam.cable.ntl.com ([80.2.244.88]:58834 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S281657AbRKUHuq>;
	Wed, 21 Nov 2001 02:50:46 -0500
From: arjan@fenrus.demon.nl
To: jmerkey@timpanogas.org (Jeff Merkey)
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
cc: linux-kernel@vger.kernel.org
In-Reply-To: <003401c1725a$975ad4e0$f5976dcf@nwfs>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E166S8l-0007hs-00@fenrus.demon.nl>
Date: Wed, 21 Nov 2001 07:49:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <003401c1725a$975ad4e0$f5976dcf@nwfs> you wrote:

> OK.  Cool.  Now we are making progress.  I think this is a nasty problem.
> There are numerous RPMs that will build against the kernel tree and be
> busted.  I would expect an rpm -ba on your DEFAULT kernel in Redhat with
> the sources contained in the kernel.rpm files to also be broken unless
> someone has done this.

That's why Red Hat ships the kernel-source RPM; you can build external
modules against that and it has the "make dep" information for all kernels
Red Hat ships for that platform (with a smart "if" that selects the
currently running one)........... But note the word "external". You build in
another directory and don't touch the original .config file or tree......
Unless you need core changes, that's perfectly possible for almost all
modules....

Greetings,
    Arjan van de Ven

