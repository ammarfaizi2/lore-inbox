Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUKCH3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUKCH3H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 02:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUKCH3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 02:29:07 -0500
Received: from fmr12.intel.com ([134.134.136.15]:32207 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261467AbUKCH3A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 02:29:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ipw2100 and 2.6.10-rc1-bk12
Date: Wed, 3 Nov 2004 15:28:43 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD5806@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ipw2100 and 2.6.10-rc1-bk12
Thread-Index: AcTBbCVXE9VoOQcoTyuioyYAxiCvlAACeT2Q
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Nov 2004 07:28:44.0872 (UTC) FILETIME=[C03CAC80:01C4C176]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcos D. Marado Torres wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Greetings,
> 
> I was trying to compile Linux Kernel 2.6.10-rc1-bk12 and
> ipw2100-0.58, but got this compiling errors:
> 
> drivers/net/wireless/ipw2100/ipw2100.c: In function
> `ipw2100_pci_init_one': drivers/net/wireless/ipw2100/ipw2100.c:6610:
> error: too many arguments to function `pci_restore_state'
> drivers/net/wireless/ipw2100/ipw2100.c: In function `ipw2100_suspend':
> drivers/net/wireless/ipw2100/ipw2100.c:6800: error: too many
> arguments to function `pci_save_state'
> drivers/net/wireless/ipw2100/ipw2100.c: In function `ipw2100_resume':
> drivers/net/wireless/ipw2100/ipw2100.c:6820: error: too many
> arguments to function `pci_restore_state'
> make[4]: *** [drivers/net/wireless/ipw2100/ipw2100.o] Error 1
> make[3]: *** [drivers/net/wireless/ipw2100] Error 2
> make[2]: *** [drivers/net/wireless] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
> 
> I'm trying to compile this with gcc (GCC) 3.4.2 (Debian 3.4.2-3).
> 
> Any ideas? I can give any extra info you need...

Here is the fix patch for ipw2100-0.56.
http://cache.gmane.org//gmane/linux/drivers/ipw2100/devel/2984-001.bin

Please do not cross post next time, ipw2100-devel@lists.sourceforge.net
should be right list for such problems.

Thanks,
-yi
