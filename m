Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTJNHx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 03:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTJNHx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 03:53:26 -0400
Received: from mail.skjellin.no ([80.239.42.67]:60396 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S261732AbTJNHxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 03:53:25 -0400
Subject: Re: [BUG] 2.6.0test7 & test4: tun.o (devfs)
From: Andre Tomt <andre@tomt.net>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, underley@underley.eu.org
In-Reply-To: <20031013214835.GA8006@schottelius.org>
References: <20031013214835.GA8006@schottelius.org>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1066118003.482.5.camel@slurv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 14 Oct 2003 09:53:24 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-13 at 23:48, Nico Schottelius wrote:
> Hello!
> 
> When loading tun.o in test7 and test4 it does not create /dev/net/tun.
> I am not familar with the devfs_create_device() call, so I cannot
> currently see what's wrong where. But I think tun.o should create the device..

It creates /dev/misc/net/tun, IIRC.

-- 
Mvh,
André Tomt
andre@tomt.net

