Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUBFTCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUBFTCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:02:32 -0500
Received: from mail.zmailer.org ([62.78.96.67]:47063 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S265622AbUBFTC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:02:28 -0500
Date: Fri, 6 Feb 2004 21:02:25 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Valdis.Kletnieks@vt.edu, Roland Dreier <roland@topspin.com>,
       "Hefty, Sean" <sean.hefty@intel.com>,
       Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040206190225.GD13308@mea-ext.zmailer.org>
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com> <Pine.LNX.4.53.0402061150100.3862@chaos> <52smhounpn.fsf@topspin.com> <Pine.LNX.4.53.0402061258110.4045@chaos> <200402061822.i16IMdHJ013686@turing-police.cc.vt.edu> <Pine.LNX.4.53.0402061336120.4238@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402061336120.4238@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 01:50:42PM -0500, Richard B. Johnson wrote:
....
> In spite of the fact that the gcc compiler I'm using doesn't
> care, and generates the same code either way, there are others
> in the world who have looked at Linux code, in particular
> the headers, and turned various shades of grey just before
> running off to the head. I have spent a bunch of time looking
> at C/C++ headers for Sun and W$ and the only place I've
> ever seen the "do {} while(0)" stuff is in Linux. I think
> it started with Linux (was a Linux Invention!), as some
> kind of work-around, then it became a "Linux Signature".

It is actually  "GCC Signature"  from way back when of 1.x versions
of gcc.  It is also exemplified by rather decent explanations, of why
  #define max(a,b) ((a > b) ? a : b)  
is bad, and should be done with way more complex thing involving
complex contortions of  do ... while(0) ...

> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i986 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.

/Matti Aarnio
