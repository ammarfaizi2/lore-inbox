Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267712AbSLTDnO>; Thu, 19 Dec 2002 22:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267715AbSLTDnO>; Thu, 19 Dec 2002 22:43:14 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:49561 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267712AbSLTDnN>; Thu, 19 Dec 2002 22:43:13 -0500
Date: Fri, 20 Dec 2002 04:51:14 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: module-init-tools 0.9.5
Message-ID: <20021220035114.GG26389@louise.pinerecords.com>
References: <20021219152942.GD26389@louise.pinerecords.com> <20021220003818.0D5622C32C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220003818.0D5622C32C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <20021219152942.GD26389@louise.pinerecords.com> you write:
> > $ uname -r
> > 2.4.20
> > 
> > [compile and install 2.5.52]
> > 
> > still in 2.4.20:
> > # depmod -V
> > module-init-tools 0.9.5
> > # depmod -ae -F /boot/System.map-2.5.52 2.5.52
> > #
> > 
> > [reboot into 2.5.52]
> > 
> > # modprobe pcnet32
> > FATAL: module pcnet32 not found.
> > # depmod -ae
> > # modprobe pcnet32
> > #
> > 
> > Hmm?
> 
> I can't reproduce that here (the two produce identical results with my
> config).  Can you send the contents of /lib/modules/2.5.52/modules.dep
> produced after each run?

Ooops.  I dropped this vmware machine in the meantime I'm afraid.  I'll
certainly let you know if I stumble upon the problem again, though.

-- 
Tomas Szepe <szepe@pinerecords.com>
