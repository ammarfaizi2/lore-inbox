Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269977AbSISPIs>; Thu, 19 Sep 2002 11:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271105AbSISPIq>; Thu, 19 Sep 2002 11:08:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4434 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S269977AbSISPIp>; Thu, 19 Sep 2002 11:08:45 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca, akpm@digeo.com,
       manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
References: <3D87A59C.410FFE3E@digeo.com>
	<Pine.GSO.4.30.0209172053360.3686-100000@shell.cyberus.ca>
	<20020917.180014.07882539.davem@redhat.com>
	<m1hegnky2h.fsf@frodo.biederman.org>
	<1032371453.20463.139.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2002 08:58:49 -0600
In-Reply-To: <1032371453.20463.139.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1d6rakouu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Wed, 2002-09-18 at 18:27, Eric W. Biederman wrote:
> > Plus I have played with calibrating the TSC with outb to port
> > 0x80 and there was enough variation that it was unuseable.  On some
> > newer systems it would take twice as long as on some older ones.
> 
> port 0x80 isnt going to PCI space.

Agreed.  It isn't going anywhere, and it takes it a while to recogonize
that.
 
> x86 generally posts mmio write but not io write. Thats quite measurable.

The difference timing difference between posted and non-posted writes
I can see.

Eric

