Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTE0T3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTE0T3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:29:36 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11639 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264092AbTE0T3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:29:34 -0400
Date: Tue, 27 May 2003 19:42:46 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Daniele <dandario@libero.it>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] HZ entry in /proc/sys/kernel
Message-ID: <20030527194246.E32598@devserv.devel.redhat.com>
References: <1053950030.2028.4.camel@nalesnik.localhost> <1053951356.32566.3.camel@laptop.fenrus.com> <20030527193957.GA288@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030527193957.GA288@libero.it>; from dandario@libero.it on Tue, May 27, 2003 at 09:39:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, May 27, 2003 at 09:39:57PM +0200, Daniele wrote:
> On Mon, May 26, 2003 at 02:15:57PM +0200, Arjan van de Ven wrote:
> > On Mon, 2003-05-26 at 13:53, Grzegorz Jaskiewicz wrote:
> > > I have seen few scripts allready that are assuming HZ==100.
> > > Afaik this value is different in 2.5/2.4 for the same arch.
> > 
> > No it's not actually.
> > The userspace interface is constant/stable and in units of HZ=100 even
> > though the kernel HZ might be different.
> > 
> 
> What's this HZ value related to?

the userspace interface is not in units of kernel HZ, but in
"theoretical time units that happen to match a defined
default" which happens to match 10ms on x86.

