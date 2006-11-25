Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966595AbWKYOw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966595AbWKYOw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 09:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966596AbWKYOw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 09:52:27 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:45576 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S966595AbWKYOw0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 09:52:26 -0500
Date: Sat, 25 Nov 2006 15:52:26 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       Riku Voipio <riku.voipio@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061125145226.GA526@deprecation.cyrius.com>
References: <20061107115940.GA23954@unjust.cyrius.com> <20061108203546.GA32247@kos.to> <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122231656.GA9991@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Francois Romieu <romieu@fr.zoreil.com> [2006-11-23 00:16]:
> It apparently does the job and it is not much too intrusive.

I can confirm that it works.  Do you think there'll be a better fix in
the future?  Do you believe that the boot loader on the N2100 doesn't
initialize Ethernet properly or that this is a generic problem on iop
or with this particular RTL chip?  We have fairly good contacts with
the company producing the N2100 so if it's the former it could
probably be fixed. (Altough I'm not sure this is the case given that
Realtek's driver works).
-- 
Martin Michlmayr
http://www.cyrius.com/
