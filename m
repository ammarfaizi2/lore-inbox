Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVEABNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVEABNC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 21:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVEABNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 21:13:02 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:27353 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261487AbVEABM7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 21:12:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZizhkzHBqFw4xRhEu9+Fl9KN0qUbUq4wpVA5R7t4Z9QNiOyJMcT3BZm1Fvs1taiOiKSPNmD2Vp/nmbkGEiwjHMjdHIKEV4ep0ICOPI9/d8eWlyRF3o4caGUIG9HeihgHO4gz9HeGRfZqpgktLb9+3mHbp0/kiZJxJPD/SttKMck=
Message-ID: <40f323d005043018126514f6a7@mail.gmail.com>
Date: Sun, 1 May 2005 03:12:59 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
In-Reply-To: <40f323d00504301753140a7ef4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050430164303.6538f47c.akpm@osdl.org>
	 <40f323d0050430172775e3b4b7@mail.gmail.com>
	 <20050430173724.3189c50f.akpm@osdl.org>
	 <40f323d00504301753140a7ef4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

forgot to cc lkml... going to sleep...

On 5/1/05, Benoit Boissinot <bboissin@gmail.com> wrote:
> On 5/1/05, Andrew Morton <akpm@osdl.org> wrote:
> > Benoit Boissinot <bboissin@gmail.com> wrote:
> > >
> > > On 5/1/05, Andrew Morton <akpm@osdl.org> wrote:
> > > >
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/
> > > >
> > > > - Various fixes against 2.6.12-rc3-mm1.
> > > >
> > > This time it boots correctly, but it oops:
> > >
> >
> > Which /proc node is it writing to?
> >
> 
> cat /proc/sys/net/ipv4/conf/eth1/proxy_arp segfaults and gives an oops.
> 
> 
> > I guess you could send your /etc/sysctl.conf and try taking things out of
> > it, see which entry is causing the crash.
> >
>
