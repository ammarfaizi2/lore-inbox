Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbUK1SkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbUK1SkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUK1SkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:40:20 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11410 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261559AbUK1SkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:40:08 -0500
Subject: Re: [patch 2.6.10-rc2] 3c59x: reload EEPROM values at rmmod for
	needy cards
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, jgarzik@pobox.com
In-Reply-To: <20041118012155.GA22765@tuxdriver.com>
References: <20041117160122.A4824@tuxdriver.com>
	 <20041117134425.62034944.akpm@osdl.org>
	 <20041118012155.GA22765@tuxdriver.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101663389.16787.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 28 Nov 2004 17:36:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-18 at 01:21, John W. Linville wrote:
> On Wed, Nov 17, 2004 at 01:44:25PM -0800, Andrew Morton wrote:
> > This has been in -mm kernels since you first sent it out.  I'm intending to
> > hold off until post-2.6.10 so we get a full kernel cycle for any problems
> > to get shaken out.
> 
> Cool...someone was asking for it in netdev-2.[46], and Jeff didn't
> have it.  That is what provoked the resend.

Merged into -ac since you essentially can't use 3c59x/3c90x with DHCP on
some systems or get it back from suspend with several distributions.
This IMHO should go into 2.6.10 because its a showstopper for many
users. 

Alan

