Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUCOE7h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 23:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUCOE7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 23:59:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:17803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261990AbUCOE7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 23:59:35 -0500
Date: Sun, 14 Mar 2004 20:54:38 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: niv@us.ibm.com, benh@kernel.crashing.org, davem@redhat.com,
       netdev@oss.sgi.com
Subject: Re: [patch/RFC] networking menus
Message-Id: <20040314205438.3d7bcd34.rddunlap@osdl.org>
In-Reply-To: <20040314190724.1af1f11d.rddunlap@osdl.org>
References: <20040314163327.53102f46.rddunlap@osdl.org>
	<4055122D.8030809@us.ibm.com>
	<20040314190724.1af1f11d.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004 19:07:24 -0800 "Randy.Dunlap" <rddunlap@osdl.org> wrote:

| On Sun, 14 Mar 2004 18:17:17 -0800 Nivedita Singhvi <niv@us.ibm.com> wrote:
| 
| | Randy.Dunlap wrote:
| | 
| | > This is just a first pass/RFC.  It moves "Networking support" out of
| | > the "Device Drivers" menu, which seems helpful to me.  However,
| | > ISTM that it should really just be the "Networking options" here
| | > and not include Amateur Radio, IrDA, and Bluetooth support.
| | > I.e., I think that those latter 3 should fall under Device Drivers.
| | > Does that make sense to anyone else?
| | 
| | Just a comment that those 3 subsystems are not just
| | device drivers, they have non-trivial amount of code
| | in the protocol stack under ../net/. So would moving
| | them to device drivers be misleading in any way?
| | 
| | I can see pulling out Networking support from under
| | device drivers, though.
| 
| Agreed, I looked again and those 3 should stay under
| "Networking support."  I'm still looking for other items
| to move to make it all easier to navigate.

Does it make sense to anyone besides me to move protocol-related
modules like SLIP, PPP, and PLIP from Device Drivers/Network device(s)
to "Networking support"?
They feel more like protocols than device drivers to me....


| | > Does this need to be discussed on netdev (also)?
| | 
| | Yes. :)
| 
| OK.  Thanks for cc-ing it.
| 
| | thanks,
| | Nivedita


--
~Randy
