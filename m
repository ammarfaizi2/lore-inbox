Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946733AbWJTAJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946733AbWJTAJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946736AbWJTAJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:09:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946737AbWJTAJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:09:25 -0400
Date: Thu, 19 Oct 2006 17:02:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?=C1lvaro_Arranz_Garc=EDa?= 
	<aarranz@pegaso.ls.fi.upm.es>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [GIT PATCH] PCI and PCI hotplug fixes for 2.6.19-rc2
In-Reply-To: <1161301380.5084.38.camel@s10n.fi.upm.es>
Message-ID: <Pine.LNX.4.64.0610191701260.3962@g5.osdl.org>
References: <20061018200238.GA29443@kroah.com>  <20061018151556.7113728c.akpm@osdl.org>
  <Pine.LNX.4.64.0610181729270.3962@g5.osdl.org> <1161301380.5084.38.camel@s10n.fi.upm.es>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-703693783-1161302570=:3962"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-703693783-1161302570=:3962
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Fri, 20 Oct 2006, Álvaro Arranz García wrote:
>
> I don't know whether this could help you, but I see that the initial
> range of memory is assigned to the cardbus at pci_bus_size_cardbus
> (drivers/pci/setup-pci.c).

Doh.

You are of course right. Try changing that CARDBUS_MEM_SIZE to 64M instead 
of 32M.

		Linus
--21872808-703693783-1161302570=:3962--
