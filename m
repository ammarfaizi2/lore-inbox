Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWJBLYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWJBLYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 07:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWJBLYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 07:24:52 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16872 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932094AbWJBLYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 07:24:51 -0400
Date: Mon, 2 Oct 2006 13:23:26 +0200 (MEST)
Message-Id: <200610021123.k92BNQRn013051@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: galibert@pobox.com, mikpe@it.uu.se
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to -mm tree
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
       rossb@google.com, sam@ravnborg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 12:42:09 +0200, Olivier Galibert wrote:
> On Mon, Oct 02, 2006 at 09:08:08AM +0200, Mikael Pettersson wrote:
> > All that's needed is to standardise the location of the
> > config file; /lib/modules/`uname -r`/config.gz seems a
> > reasonable choice.
> 
> It's already /boot/config-`uname -r`, why change?

I just wanted to show that the instant /proc/config.gz gets implemented
as a loadable module, it no longer needs to be in the kernel at all,
and in the heat of the moment I forgot about the /boot/config-`uname -r`
convention. I am certainly not suggesting that that convention should be changed.

/Mikael
