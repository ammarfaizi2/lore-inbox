Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTJGAP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 20:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTJGAP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 20:15:28 -0400
Received: from mail2-116.ewetel.de ([212.6.122.116]:14493 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S261762AbTJGAP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 20:15:27 -0400
Date: Tue, 7 Oct 2003 02:15:23 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/6] Backing Store for sysfs
In-Reply-To: <20031006191004.GA12979@kroah.com>
Message-ID: <Pine.LNX.4.44.0310070210580.32013-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Greg KH wrote:

> Systems like this are not uncommon, I agree.  But also for systems like
> this, the current code works just fine (small number of fixed devices.)
> I haven't heard anyone complain about memory usage for a normal system
> (99.9% of the systems out there.)

I'd like my kernel to have as small a footprint as possible. Allocated
memory that is almost never used is waste. It may not be much, but 
"add little to little and you will have a big pile". Whatever, we're
not the big pile yet and I'm not concerned enough to cook up patches.

> Also,  remember that in 2.7 I'm going to make device numbers random so
> you will have to use something like udev to control your /dev tree.
> Slowly weaning yourself off of a static /dev during the next 2 years or
> so might be a good idea :)

I guess by then we'll have an excellent udev version with no known
bugs. ;) However, requiring more and more packages to be installed just
to boot a system is also not something I like much.

-- 
Ciao,
Pascal

