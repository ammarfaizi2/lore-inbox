Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263092AbSJBNVf>; Wed, 2 Oct 2002 09:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbSJBNVf>; Wed, 2 Oct 2002 09:21:35 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:52472 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263092AbSJBNVe>; Wed, 2 Oct 2002 09:21:34 -0400
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021002042434.GA13971@think.thunk.org>
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu>
	<Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it>
	<20021001154808.GD126@suse.de> <20021001184225.GC29788@marowsky-bree.de>
	<1033520458.20284.46.camel@irongate.swansea.linux.org.uk> 
	<20021002042434.GA13971@think.thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 14:34:29 +0100
Message-Id: <1033565669.23682.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 05:24, Theodore Ts'o wrote:
> DM is small and clean because it's severely lacking in functionality.
> Last I checked it couldn't do RAID 5 or r/w snapshots without
> completely bypassing its core infrastructure (since you're no longer
> just doing simple block remapping at that point), and once you add all
> that stuff, it's likely to become much more complex.

Last time I checked we already had a perfectly good md driver for the
raid5 handling

