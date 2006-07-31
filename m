Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWGaEun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWGaEun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWGaEun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:50:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751269AbWGaEun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:50:43 -0400
Date: Sun, 30 Jul 2006 21:50:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       laurent.riffard@free.fr, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-Id: <20060730215025.44292f9c.akpm@osdl.org>
In-Reply-To: <20060731043542.GA9919@kroah.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<44CCBBC7.3070801@free.fr>
	<20060731000359.GB23220@kroah.com>
	<200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20060731033757.GA13737@kroah.com>
	<20060730212227.175c844c.akpm@osdl.org>
	<20060731043542.GA9919@kroah.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 21:35:42 -0700
Greg KH <greg@kroah.com> wrote:

> Remember, FC3 is now in Legacy support mode, not something the mainline
> kernel should have to worry about.

It's not specifically related to FC3.  It's udev - we've broken _any_
distribution which uses a two-year-old udev.  In fact we're proposing
breaking any distro which has an older-than-ten-month udev.  That's really
bad.

It's worse on FC3 because there is, as far as I can tell, no rpm or srpm
which can be used to unbreak it.  And pointing at Documentation/Changes
doesn't alter that, does it?

Personally, there's no way I'm upgrading this box because I _want_ to run
old distros to catch things like this.  So I'll hack it around to work
somehow.  I can do that, because I'm a developer. 

Are we going to stop doing this soon?
