Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263200AbTC1XTG>; Fri, 28 Mar 2003 18:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263203AbTC1XTF>; Fri, 28 Mar 2003 18:19:05 -0500
Received: from [66.62.77.7] ([66.62.77.7]:156 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id <S263200AbTC1XTE>;
	Fri, 28 Mar 2003 18:19:04 -0500
Date: Fri, 28 Mar 2003 16:30:20 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NICs trading places ?
In-Reply-To: <20030328221037.GB25846@suse.de>
Message-ID: <Pine.LNX.4.44.0303281626260.20589-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Dave Jones wrote:

> I just upgraded a box with 2 NICs in it to 2.5.66, and found
> that what was eth0 in 2.4 is now eth1, and vice versa.
> Is this phenomenon intentional ? documented ?
> What caused it to do this ?

I've seen the same thing for 5+ years.  Multiple things can 
trigger it, eg:

Always having your NIC drivers compiled in, and then moving between 
different kernel versions.

Going from modular NIC drivers to compiled in drivers can bite you.

Isn't life fun.

Dax

