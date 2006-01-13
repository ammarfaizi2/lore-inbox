Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422845AbWAMT2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbWAMT2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422849AbWAMT2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:28:40 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:50436 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422841AbWAMT2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:28:39 -0500
Date: Fri, 13 Jan 2006 20:28:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [git patches] 2.6.x net driver updates
Message-ID: <20060113192813.GA10560@mars.ravnborg.org>
References: <20060112221322.GA25470@havoc.gtf.org> <Pine.LNX.4.64.0601121423120.3535@g5.osdl.org> <20060112143938.5cf7d6a5.akpm@osdl.org> <20060113192316.GX3945@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113192316.GX3945@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 08:23:16PM +0100, Jens Axboe wrote:
> 
> 'select' is really cool as a concept, but when you can't figure out why
> you cannot disable CONFIG_FOO because CONFIG_BAR selects it it's really
> annoying. Would be nice to actually be able to see if another option has
> selected this option.

In menuconfig:

Typing '?' on CONFIG_HOTPLUG revealed:
 Selected by: PCCARD || HOTPLUG_PCI && PCI && EXPERIMENTAL || FW_LOADER

Then use '/' to search for the CONFIG_ symbols to see where they are
defined.

	Sam
