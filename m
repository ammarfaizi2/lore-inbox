Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUFNR0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUFNR0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUFNR0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:26:02 -0400
Received: from mid-2.inet.it ([213.92.5.19]:52725 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S263614AbUFNRZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:25:48 -0400
Message-ID: <40CDDF6F.2070502@yahoo.it>
Date: Mon, 14 Jun 2004 19:25:03 +0200
From: Sandro <nahidesafe-linux@yahoo.it>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Toshiba 1800-100 linux-2.6.x Driver for the SMC Infrared
 Communications Controller does not work
References: <E1BZle8-00035D-Cs@rhn.tartu-labor>
In-Reply-To: <E1BZle8-00035D-Cs@rhn.tartu-labor>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Meelis Roos wrote:

> It's a known problem. The reason is that Toshiba BIOS does not enable
> the SMC irda controller. You can verify it useing lspnp -v (at least I
> can on my 1800-314). If you enable the device by hand, it will work.

Yes, I've read that, and as you say:

> There is a Linux program for enabling the irda controller, look at
> http://www.csai.unipa.it/peri/toshsat1800-irdasetup/ .

That now is moved to:
http://irda.sourceforge.net/smcinit/index.html

according to the above page:
[quote]
Here are the prerequisites to successfully compile and install SMCINIT 
package:
     * have a Linux 2.4.x based system. Preferably Linux 2.4.18 kernel 
or better.
[/quote]

The authors wrote also:
[quote]
While this problem will be fixed in Linux 2.6.x kernel series, the 2.4.x 
users are frustrated. Daniele Peri, Rob Miller and Paul Hampson mananged 
to build little utilities that initialize the LPC47N227 SuperIO allowing 
smc-ircc IrDA kernel driver to detect and use the SMSC chip.
[/quote]

I've a 2.6.7-rc3 kernel, this bug report is mostly a feedback message.
The Toshiba 1800-100 is not listed in the table written by Thomas Pinz.
I have written here with the hope that the data present in the mail may 
help the authors finding what's wrong in the init code for the driver or 
in the finding some working parameters.

-- 
Sandro


