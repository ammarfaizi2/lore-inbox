Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVL0AC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVL0AC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 19:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVL0AC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 19:02:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:28839 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932169AbVL0AC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 19:02:28 -0500
Date: Mon, 26 Dec 2005 15:54:26 -0800
From: Greg KH <gregkh@suse.de>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       venkatesh.pallipadi@intel.com
Subject: Re: [patch 01/19] ACPI: Add support for FADT P_LVL2_UP flag
Message-ID: <20051226235426.GA21027@suse.de>
References: <20051223221200.342826000@press.kroah.org> <20051223224737.GA19057@kroah.com> <43AD73CF.1050502@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AD73CF.1050502@gentoo.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2005 at 04:14:07PM +0000, Daniel Drake wrote:
> Greg Kroah-Hartman wrote:
> >-stable review patch.  If anyone has any objections, please let us know.
> >
> >------------------
> >From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> >
> >[ACPI] Add support for FADT P_LVL2_UP flag
> >which tells us if C2 is valid for UP-only, or SMP.
> >
> >As there is no separate bit for C3,  use P_LVL2_UP
> >bit to cover both C2 and C3.
> >
> >http://bugzilla.kernel.org/show_bug.cgi?id=5165
> >
> 
> Sorry, we should probably drop this one (and #2) again. The required 3rd 
> patch was only recently added to Linus' tree and I didn't get a chance 
> to send it to you.

Ok, I've moved these two to the "rejects" pile.  If you ever get this
all working, feel free to send the needed patches for it.

thanks for letting us know.

greg k-h
