Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWH1MFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWH1MFm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWH1MFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:05:42 -0400
Received: from colin.muc.de ([193.149.48.1]:17682 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S964835AbWH1MFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:05:42 -0400
Date: 28 Aug 2006 14:05:40 +0200
Date: Mon, 28 Aug 2006 14:05:40 +0200
From: Andi Kleen <ak@muc.de>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Marc Perkel <marc@perkel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACurrid@nvidia.com, len.brown@intel.com
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060828120540.GA69511@muc.de>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <Pine.LNX.4.64.0608272246350.27779@g5.osdl.org> <20060828061302.GA45823@muc.de> <200608280924.47968.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608280924.47968.prakash@punnoor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At least my dmesg says nothing about hpet and thus wan't to enable the quirk. 
> It is a nforce430 (thus nf4) chipset, though. You can find my bootlog here:

Only NF5 is interesting in this case. On NF4 skipping the timer override
is correct.

-Andi
