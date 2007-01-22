Return-Path: <linux-kernel-owner+w=401wt.eu-S1751528AbXAVKji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbXAVKji (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 05:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbXAVKji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 05:39:38 -0500
Received: from ns.firmix.at ([62.141.48.66]:44150 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbXAVKjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 05:39:37 -0500
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Heikki Orsila <shdl@zakalwe.fi>,
       Bodo Eggert <7eggert@gmx.de>, Tony Foiani <tkil@scrye.com>,
       Leon Woestenberg <leon.woestenberg@gmail.com>,
       linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
In-Reply-To: <m38xfvrfhm.fsf@maximus.localdomain>
References: <7FsPf-51s-9@gated-at.bofh.it> <7FxlV-3sb-1@gated-at.bofh.it>
	 <7FyUF-5XD-21@gated-at.bofh.it> <E1H8a7s-0000at-Jx@be1.lrz>
	 <20070121150618.GA11613@zakalwe.fi>
	 <Pine.LNX.4.61.0701212223340.29213@yvahk01.tjqt.qr>
	 <m38xfvrfhm.fsf@maximus.localdomain>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 22 Jan 2007 11:39:19 +0100
Message-Id: <1169462359.6167.49.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-Firmix-Scanned-By: MIMEDefang 2.56 on ns.firmix.at
X-Firmix-Spam-Score: -2.413 () AWL,BAYES_00,FORGED_RCVD_HELO
X-Firmix-Spam-Status: No, hits=-2.413 required=5
X-Spam-Score: -2.413 () AWL,BAYES_00,FORGED_RCVD_HELO
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-22 at 02:56 +0100, Krzysztof Halasa wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
> 
> > Bleh. Except for storage, base 1024 was used for almost everything
> > I remember. 4 MB memory meant 4096 KB, and that's still the case today.
> > Most likely the same for transfer rates.
> 
> Nope, transfer rates were initially 1000-based: 9.6 kbps = 9600 bps,
> 28.8 kbps = 28800 bps, 64 kbps = 64000 bps. Then it went 128, 256,
> 512 kbps = 512000 bps and 1 Mbps = 2 * 512 kbps = 1024000 bps.

ACK. But this and harddisk sizes are really the only areas.

> But it's limited mostly to serial interfaces. Other networks use
> 10, 1000 etc. because they have nothing natural in (powers of) 2
> so 1 Mbps may be 1000000 bps as well.
> 
> > It's just that storage vendors broke the computer rule and went with 1000.
> 
> 1024 etc. is (should be) natural to disks because the sector size
> is 512 B, 2048 B or something like that.

Yes, but it sounds in commercials better if there is a larger number
there. And you can raise the result of a fraction if you lower the
divisor.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

