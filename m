Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031428AbWKUUp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031428AbWKUUp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031427AbWKUUp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:45:28 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:29855 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1031428AbWKUUp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:45:27 -0500
Date: Tue, 21 Nov 2006 21:45:27 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       Riku Voipio <riku.voipio@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)]
Message-ID: <20061121204527.GA13549@electric-eye.fr.zoreil.com>
References: <20061107115940.GA23954@unjust.cyrius.com> <20061108203546.GA32247@kos.to> <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121102458.GA7846@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr <tbm@cyrius.com> :
[...]
> Did you have any success ?

I was not able to reproduce the results expected from a driver close to
the one which was supposed to work back with 2.6.18-rc4. OTOH, as Lennert
noticed, simply ignoring the PCI data parity errors seems to do the trick.
There are quite a lot of these errors though.

I'll do one or two more tests but the driver will surely be simply added
a big knob to control its behavior when parity errors appear.

-- 
Ueimor
