Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268428AbTCCICN>; Mon, 3 Mar 2003 03:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268431AbTCCICN>; Mon, 3 Mar 2003 03:02:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1798 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268428AbTCCICL>;
	Mon, 3 Mar 2003 03:02:11 -0500
Date: Mon, 3 Mar 2003 08:12:34 +0000
From: Matthew Wilcox <willy@debian.org>
To: Amit Shah <shahamit@gmx.net>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taskqueue to workqueue update for riscom8 driver
Message-ID: <20030303081234.G7301@parcelfarce.linux.theplanet.co.uk>
References: <20030302043804.A17185@parcelfarce.linux.theplanet.co.uk> <200303021751.01224.shahamit@gmx.net> <20030302163427.C7301@parcelfarce.linux.theplanet.co.uk> <200303031305.22854.shahamit@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303031305.22854.shahamit@gmx.net>; from shahamit@gmx.net on Mon, Mar 03, 2003 at 01:05:22PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 01:05:22PM +0530, Amit Shah wrote:
> A simple grep for cli() in drivers/char reveals that many of those drivers 
> still use cli(), which means even they haven't yet been converted to the new 
> framework.

Yes.  Serial drivers still in drivers/char have not been converted to
the new serial core.  Part of the conversion process moves the drivers
to drivers/serial.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
