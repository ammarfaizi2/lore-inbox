Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSHBOTG>; Fri, 2 Aug 2002 10:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSHBOTG>; Fri, 2 Aug 2002 10:19:06 -0400
Received: from mail1.cirrus.com ([141.131.3.20]:35996 "EHLO mail1.cirrus.com")
	by vger.kernel.org with ESMTP id <S314278AbSHBOTF>;
	Fri, 2 Aug 2002 10:19:05 -0400
Message-ID: <973C11FE0E3ED41183B200508BC7774C05233F06@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <tom.woller@cirrus.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, davidm@hpl.hp.com
Cc: "Woller, Thomas" <tom.woller@cirrus.com>, audio@crystal.cirrus.com,
       linux-kernel@vger.kernel.org
Subject: RE: cs4281 driver cleanup (includes synchronize_irq() update)
Date: Fri, 2 Aug 2002 09:22:24 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks david/alan. we just turned our ia64 bit machines back to
intel, so I can't test itanium any longer.  INTEL didn't have any
issues with 64-bit functionality that they reported as of the 2.4
base quite a while back. i looked over the mods and they seem
fine to me. thanks for the work on the driver
tom

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Friday, August 02, 2002 8:06 AM
To: davidm@hpl.hp.com
Cc: twoller@crystal.cirrus.com; audio@crystal.cirrus.com;
linux-kernel@vger.kernel.org
Subject: Re: cs4281 driver cleanup (includes synchronize_irq()
update)


On Fri, 2002-08-02 at 00:31, David Mosberger wrote:
> The patch below cleans up the cs4281 sound driver to compile
cleanly
> (no warnings) on 64-bit platforms such as ia64.  Also, the
patch
> updated the calls to synchronize_irq() according to the new
interface
> (which takes an irq number as an argument).  Someone who
understands
> this driver might want to double check that this is indeed
working as
> intended.

I'll double check it and backport the changes to 2.4
