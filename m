Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTIVT12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTIVT12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:27:28 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:33916 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263137AbTIVT11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:27:27 -0400
Date: Mon, 22 Sep 2003 21:27:18 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Message-ID: <20030922212718.A13166@devserv.devel.redhat.com>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com> <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk> <20030922162602.GB27209@mail.jlokier.co.uk> <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk> <1064250691.6235.2.camel@laptop.fenrus.com> <20030922182808.GA28372@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030922182808.GA28372@mail.jlokier.co.uk>; from jamie@shareable.org on Mon, Sep 22, 2003 at 07:28:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 07:28:08PM +0100, Jamie Lokier wrote:
> Arjan van de Ven wrote:
> > The first person to complain about the extra branch miss in udelay for
> > this will get laughed at by me ;)
> 
> udelay(1) is too slow on a 386 even without the branch miss.


ok we have ndelay() now as well in 2.6
