Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbULUTC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbULUTC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULUTC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:02:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:19652 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261337AbULUS6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:58:10 -0500
Date: Tue, 21 Dec 2004 10:54:24 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ETH_P_AOE (was Re: [PATCH] ATA over Ethernet driver for 2.6.10-rc3-bk11)
Message-ID: <20041221185424.GB8656@kroah.com>
References: <87k6rhc4uk.fsf@coraid.com> <1103356085.3369.140.camel@sfeldma-mobl.dsl-verizon.net> <87k6rd7xfy.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6rd7xfy.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 11:21:05AM -0500, Ed L Cashin wrote:
> Scott Feldman <sfeldma@pobox.com> writes:
> 
> > On Fri, 2004-12-17 at 07:38, Ed L Cashin wrote:
> >
> >> +       ETH_P_AOE = 0x88a2,
> >
> > include/linux/if_ether.h already defines this as ETH_P_EDP2=0x88A2; use
> > that.
> 
> Ah, that's old.  It's not just "EtherDrive protocol" but the ATA over
> Ethernet protocol.
> 
> Here's a patch for 2.6.10-rc3-bk11 that goes on top of the aoe patch
> in this thread.

Applied to my trees, thanks.

greg k-h
