Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVGWGq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVGWGq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 02:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVGWGq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 02:46:57 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:43741 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261291AbVGWGq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 02:46:56 -0400
Message-ID: <42E1E94C.3000703@stesmi.com>
Date: Sat, 23 Jul 2005 08:53:00 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume... (non-fbdev/con)
References: <Pine.LNX.4.58.0507221942540.5475@skynet> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk> <20050723003140.GB1988@elf.ucw.cz> <E1Dw80M-0001EG-00@chiark.greenend.org.uk> <20050723004745.GA7868@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050723004745.GA7868@atrey.karlin.mff.cuni.cz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
> Hi!
> 
> 
>>>Unfortunately, if you only get printk() working after you ran
>>>userspace app... well it makes debugging things like SATA
>>>"interesting". So I quite like this patch.
>>
>>Most interesting laptop vendors have at least one model in each range
>>with a serial port, which makes this sort of thing a bit easier. 
> 
> 
> Well, we have debugged with beeps, but... It would be cool if someone
> got usb debug mode working but... and there are hardware debuggers.
> 
> Anyway, this patch is really good, and enables S3 to work on more
> machines. Thats good. It is not intrusive and I'll probably (try to)
> push it.

If kdb is your thing then SGI has gotten kdb work over USB using
OHCI chipsets. They haven't done UHCI (Yet?).

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFC4elMBrn2kJu9P78RAlqqAJ4iKFeCf4Iomic7UzyWNLLztIqXkgCggc4L
xyzG4KWvlUT15roBjWhtMhE=
=j79y
-----END PGP SIGNATURE-----
