Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWIFHXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWIFHXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWIFHXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:23:33 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:42896 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751226AbWIFHXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:23:31 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda: small cleanups)
Date: Wed, 6 Sep 2006 09:23:19 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, pshou@realtek.com.tw
References: <20060831123706.GC3923@elf.ucw.cz> <20060905080813.GE1958@elf.ucw.cz> <20060905084352.1ced999e.rdunlap@xenotime.net>
In-Reply-To: <20060905084352.1ced999e.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609060923.22459.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 5. September 2006 17:43, Randy.Dunlap wrote:
> Is there an acceptable way to leave source code in a file but
> render it unused?  Like #if 0/#endif or #if BOGUS_SYMBOL/#endif ?

They are to reading like gaps in a road.

If you really need to keep unused code for reference
just do it in your LOCAL repository.

There are exceptions where you remove the last user of code 
in one patch and a different developer just needs this code
for his new stuff in another patch.

In this case an #if 0/#endif is quite common to reduce merging
conflicts.

Regards

Ingo Oeser
