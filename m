Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTIAFbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 01:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTIAFbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 01:31:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41872 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261625AbTIAFbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 01:31:42 -0400
Date: Sun, 31 Aug 2003 22:22:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: khc@pm.waw.pl, jes@trained-monkey.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-Id: <20030831222233.1bd41f01.davem@redhat.com>
In-Reply-To: <1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl>
	<m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org>
	<m3n0dz5kfg.fsf@defiant.pm.waw.pl>
	<20030824060057.7b4c0190.davem@redhat.com>
	<m365kmltdy.fsf@defiant.pm.waw.pl>
	<m365kex2rp.fsf@defiant.pm.waw.pl>
	<20030830185007.5c61af71.davem@redhat.com>
	<1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003 13:52:55 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sul, 2003-08-31 at 02:50, David S. Miller wrote:
> > On 30 Aug 2003 23:18:50 +0200
> > Krzysztof Halasa <khc@pm.waw.pl> wrote:
> > 
> > > David, any comments?
> > 
> > I'm too busy to partake in this thread right now, sorry.
> 
> Then I suggest we remove the feature until 2.7 since nobody has time
> to make it work in 2.6

The problem is that it works for the people it was created
for, you're going to break things for them.
