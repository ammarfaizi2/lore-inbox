Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269703AbSISPN1>; Thu, 19 Sep 2002 11:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269951AbSISPN1>; Thu, 19 Sep 2002 11:13:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6994 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S269703AbSISPN0>; Thu, 19 Sep 2002 11:13:26 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, ebiederm@xmission.com, hadi@cyberus.ca,
       akpm@digeo.com, manfred@colorfullife.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
References: <1032381789.20498.151.camel@irongate.swansea.linux.org.uk>
	<20020918.134630.127509858.davem@redhat.com>
	<1032383727.20463.155.camel@irongate.swansea.linux.org.uk>
	<20020918.142250.130847722.davem@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2002 09:03:39 -0600
In-Reply-To: <20020918.142250.130847722.davem@redhat.com>
Message-ID: <m18z1ykoms.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 18 Sep 2002 22:15:27 +0100
>    
>    It doesnt matter what XFree86 is doing. Thats just to load the PCI bus
>    and jam it up to prove the point. It'll change your inb timing
>    
> Understood.  Maybe a more accurate wording would be "a fixed minimum
> timing".

Why?

If I do an inb to a PCI-X device running at 133Mhz it should come back
much faster than an inb from my serial port on the ISA port.  What
is the reason for the fixed minimum timing?

Alan asserted there is a posting behavior difference, but that should
not affect reads.

What is different between mmio and pio to a pci device when doing reads
that should make mmio faster?

Eric

