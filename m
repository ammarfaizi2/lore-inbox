Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUB0OiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUB0OiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:38:10 -0500
Received: from fmr10.intel.com ([192.55.52.30]:2456 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262882AbUB0OiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:38:04 -0500
Subject: Re: 2.6.1: why auto power-off while on batteries?
From: Len Brown <len.brown@intel.com>
To: EricAltendorf@orst.edu
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F3C7C@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F3C7C@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077892679.22401.175.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Feb 2004 09:37:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-26 at 19:32, Eric Altendorf wrote:
> Since I've upgraded my Fedora 1 distro to 2.6.1+swsusp, I've noticed 
> that while on battery power (and only then), the laptop will auto 
> poweroff after about 5 minutes of inactivity.  This does not appear 
> to be a user-level acpid/whatever clean shutdown; the power is just 
> cut without so much as a disk sync.  Of course there are no entries 
> in /var/log/messages.
> 
> Any ideas anyone?

check dmesg to be sure that APM is disabled, and that ACPI is enabled.

cheers,
-Len

ps. acpi-devel@lists.sourceforge.net is a good place for issues such as
this.

