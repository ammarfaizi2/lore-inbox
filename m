Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWBMJ2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWBMJ2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWBMJ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:28:46 -0500
Received: from soohrt.org ([85.131.246.150]:24216 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S1751672AbWBMJ2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:28:45 -0500
Date: Mon, 13 Feb 2006 10:28:44 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: linux-kernel@vger.kernel.org
Cc: Hans Reiser <reiser@namesys.com>, Vitaly Fertman <vitaly@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [BUG] reiserfs/super.c commit breaks boot process in stable and HEAD
Message-ID: <20060213092844.GY22994@quickstop.soohrt.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>,
	Vitaly Fertman <vitaly@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Greg Kroah-Hartman <gregkh@suse.de>
References: <20060207160819.GR22994@quickstop.soohrt.org> <20060211135003.GV22994@quickstop.soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211135003.GV22994@quickstop.soohrt.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst Schirmeier schrieb am Samstag, den 11. Februar 2006:
> On Tue, Feb 07, 2006, Horst Schirmeier wrote:
> > Hi,
> > 
> > I'm observing an instant reboot while booting current stable or HEAD
> > kernels since a recent ReiserFS commit. Details and temporary fix
> > below.
> > [...]
> 
> Just for the records: I've opened a bug report on bugme.osdl.org.
> http://bugme.osdl.org/show_bug.cgi?id=6054

Fixed by Jeff Mahoney's patch, commit
89edc3d2b429136a0e25f40275fd82dc58f147fd ("[PATCH] reiserfs: disable
automatic enabling of reiserfs inode attributes"), so 2.6.16-rc3 works
for me again.

I suggest to backport this to 2.6.15.y.

Kind regards,
 Horst Schirmeier

-- 
PGP-Key 0xD40E0E7A
