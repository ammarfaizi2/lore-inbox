Return-Path: <linux-kernel-owner+w=401wt.eu-S1030505AbWLPA5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbWLPA5R (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 19:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbWLPA5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 19:57:17 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:39652 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030494AbWLPA5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 19:57:16 -0500
Date: Sat, 16 Dec 2006 01:54:39 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Riku Voipio <riku.voipio@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061216005439.GB11288@electric-eye.fr.zoreil.com>
References: <20061108203546.GA32247@kos.to> <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com> <20061215132740.GD11579@xi.wantstofly.org> <20061215201522.GA11288@electric-eye.fr.zoreil.com> <20061215210329.GB14860@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215210329.GB14860@xi.wantstofly.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek <buytenh@wantstofly.org> :
[...]
> No, that wouldn't make sense, that's like making a workaround depend on
> arch == i386.
> 
> I'm thinking that we should somehow enable this option on the n2100
> built-in r8169 ports by default only.  Since the n2100 also has a mini-PCI
> slot, and it is in theory possible to put an r8169 on a mini-PCI card,
> the workaround probably shouldn't apply to those, so testing for
> CONFIG_MACH_N2100 also isn't the right thing to do.

Ok, I thought it was a useability thing.

Let aside a few configurations, the sensible default value for this
option is not clear. I have no objection against a patch but it seems
a bit academic as long as nobody complains (you can call me lazy too).

-- 
Ueimor
