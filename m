Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWGQAeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWGQAeX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 20:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWGQAeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 20:34:23 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:3243 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751488AbWGQAeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 20:34:22 -0400
Date: Sun, 16 Jul 2006 17:34:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>
Cc: Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-ID: <20060717003418.GA27166@tuatara.stupidest.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org> <44BA48A0.2060008@gentoo.org> <20060716183126.GB4483@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716183126.GB4483@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 11:31:26AM -0700, Greg KH wrote:

> Looks ok to me, but I'll defer to Jeff for this one.

Could we make sure this doesn't cause any regressions with KT800
chipsets (I think that's it, the VIA thing used on some Athlon64
mainboards).

IIRC some require the quirk and some seem to work without it, the
later class can use the IOAPIC and if we do this might be be breaking
that?
