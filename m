Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267617AbUHMWqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267617AbUHMWqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUHMWqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:46:51 -0400
Received: from the-village.bc.nu ([81.2.110.252]:39898 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267617AbUHMWqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:46:45 -0400
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though
	sysfs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040813155312.98961.qmail@web14929.mail.yahoo.com>
References: <20040813155312.98961.qmail@web14929.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092433428.25002.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 22:43:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 16:53, Jon Smirl wrote:
> What should the API for this look like? We could add a VGA={0/1}
> attribute to all the VGA devices in sysfs.
> 
> But then how do you:
> 1) list all of the conflicting VGA devices in a domain?
> 2) turn off all the VGA devices in a domain?

1. Is part of the PCI specification since there is a PCI class for
VGA video devices. 2 follows naturally from 1

