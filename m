Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423078AbWJRWRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423078AbWJRWRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423082AbWJRWRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:17:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423081AbWJRWQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:16:59 -0400
Date: Wed, 18 Oct 2006 15:15:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>, aarranz@pegaso.ls.fi.upm.es,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [GIT PATCH] PCI and PCI hotplug fixes for 2.6.19-rc2
Message-Id: <20061018151556.7113728c.akpm@osdl.org>
In-Reply-To: <20061018200238.GA29443@kroah.com>
References: <20061018200238.GA29443@kroah.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 13:02:38 -0700
Greg KH <gregkh@suse.de> wrote:

> Here are some PCI and PCI hotplug patches for 2.6.19-rc2, and a single
> PnP fix too.

Speaking of which...  does anyone know what's going on with
http://bugzilla.kernel.org/show_bug.cgi?id=7384 ? 

pccard: CardBus card inserted into slot 0
PCI: Failed to allocate mem resource #0:1000000@6c000000 for 0000:07:00.2

we seem to be seeing quite a few such reports lately.
