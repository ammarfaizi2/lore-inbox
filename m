Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVACNLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVACNLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVACNLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:11:32 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:53901 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261435AbVACNLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:11:30 -0500
Date: Mon, 3 Jan 2005 14:11:15 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Altix hang on boot with 2.6.8+
Message-ID: <20050103131115.GL26303@fi.muni.cz>
References: <20050103125200.GK26303@fi.muni.cz> <16872.1104757249@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16872.1104757249@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.42
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
: On Mon, 3 Jan 2005 13:52:00 +0100, 
: Jan Kasprzak <kas@fi.muni.cz> wrote:
: >I cannot boot a 2.6.8 or 2.6.10 kernel on my SGI Altix - it hangs during
: >boot after printing this:
: >
: >[...]
: >CPU 0: base freq=200.000MHz, ITC ratio=14/2, ITC freq=1400.000MHz+/--1ppm
: >Console: colour dummy device 80x25
: 
: The Altix console changed from ttyS0 to ttySG0 around 2.6.8.  You need to

OK, thanks. I have found that few minutes after sending my previous mail
- 2.6.8 booted even without console. I did not wait long enough, because
2.6.10 did not boot even after a long time - so there may be some other
problem with 2.6.10 or with our init scripts on 2.6.10.

:   mknod ttySG0 c 204 40

	Thanks again,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
