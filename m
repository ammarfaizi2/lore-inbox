Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269958AbTGWJOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 05:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270441AbTGWJOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 05:14:35 -0400
Received: from netix1.demon.co.uk ([212.228.80.161]:14863 "EHLO netunix.com")
	by vger.kernel.org with ESMTP id S269958AbTGWJOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 05:14:32 -0400
Date: Wed, 23 Jul 2003 10:35:56 +0100 (BST)
From: "C.Newport" <crn@netunix.com>
To: "David S. Miller" <davem@redhat.com>
cc: <solca@guug.org>, <hch@infradead.org>, <zaitcev@redhat.com>,
       <linux-kernel@vger.kernel.org>, <sparclinux@vger.kernel.org>,
       <debian-sparc@lists.debian.org>
Subject: Re: sparc scsi esp depends on pci & hangs on boot
In-Reply-To: <20030723012824.5d8dec9b.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0307231031240.26107-100000@hek.netunix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003, David S. Miller wrote:

> On Wed, 23 Jul 2003 09:33:40 +0100 (BST)
> "C.Newport" <crn@netunix.com> wrote:
>
> > Ouch - As I mentioned a few days ago, the Ex000 range can have a
> > mixture of SBUS and PCI.
>
> So what?
>
> > This configuration is becoming increasingly
> > common as these machines are upgraded to attach to SAN stuff and
> > other FCAL variants for which there is no SBUS card.
>
> Nothing I have said prevents these systems from fully
> working.
>
> Because I won't move SBUS over to generic struct device,
> none of the SBUS device drivers will change either, therefore
> everything works as it does today.
>
> What's the problem?

In that case none, but your original message implied that this did
not exist and would not be supported.

Maybe I misunderstood what you meant.

OTOH, (if !SBUS) might screw up ?.


