Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUANSQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUANSQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:16:39 -0500
Received: from sarvega.com ([161.58.151.164]:57105 "EHLO sarvega.com")
	by vger.kernel.org with ESMTP id S262425AbUANSQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:16:37 -0500
Date: Wed, 14 Jan 2004 12:16:27 -0600
From: John Lash <jkl@sarvega.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: s0095670@sms.ed.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: Catch 22
Message-Id: <20040114121627.41cfd4b2.jkl@sarvega.com>
In-Reply-To: <20040114091456.752ad02d.rddunlap@osdl.org>
References: <400554C3.4060600@sms.ed.ac.uk>
	<20040114090137.5586a08c.jkl@sarvega.com>
	<20040114091456.752ad02d.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.6claws71 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 09:14:56 -0800
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

...
 
> Does anyone know the reason for this (ATA ident/naming change)?
> 
> I do *not* see this and I'm also using Mandrake (v9.0, not later).
> 

I didn't see anything like that for ide disks. What I did notice is that my eth
devices (on different busses) had new names sometime back in 2.5.x time. I wrote
that off to differences in walking/probing of the PCI tree giving different
enumeration of the devices. Possibly the same would hold true for the ide if
there are multiple ide interfaces on the system.

As I recall, there's also a kernel param for "Boot off-board chipsets first
support". Maybe that bit got flipped inadvertently???

--john

> --
> ~Randy
> MOTD:  Always include version info.
> -
