Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUGBH4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUGBH4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 03:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUGBH4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 03:56:22 -0400
Received: from [213.146.154.40] ([213.146.154.40]:20660 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266495AbUGBH4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 03:56:21 -0400
Subject: Re: 2.6.7-bk way too fast
From: David Woodhouse <dwmw2@infradead.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Ricky Beam <jfbeam@bluetronic.net>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040621082355.GB1200@ucw.cz>
References: <40D64DF7.5040601@pobox.com>
	 <Pine.GSO.4.33.0406202320020.25702-100000@sweetums.bluetronic.net>
	 <20040621082355.GB1200@ucw.cz>
Content-Type: text/plain
Date: Fri, 02 Jul 2004 08:53:16 +0100
Message-Id: <1088754797.4224.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 10:23 +0200, Vojtech Pavlik wrote:
> x86-64 has a different HPET driver than i386. And HPET is only used when
> present in the machine (so far only AMD chipsets), _and_ reported by the
> ACPI BIOS. Which is rather uncommon.

If we know which chipsets have it, why would we refrain from using it
just because the BIOS doesn't report it?

-- 
dwmw2

