Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVBPIlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVBPIlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 03:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVBPIlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 03:41:16 -0500
Received: from pop.gmx.de ([213.165.64.20]:44215 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261960AbVBPIlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 03:41:14 -0500
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
To: acpi-devel@lists.sourceforge.net, Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Wed, 16 Feb 2005 09:48:42 +0100
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       seife@suse.de, rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <e796392205021521541da7ee25@mail.gmail.com>
In-Reply-To: <e796392205021521541da7ee25@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502160948.43005.stefandoesinger@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The problems with this patch are:
> - you need to press a key to come back from the "resume-console" after
> resume. - DRI in X does not work (at least for me with intel-agp, others
> reportet it works)
> I just disabloed it by not loading intel-agp (hotplug-blacklist)
You can force the radeon X driver to use pci mode by setting Option 
"ForcePciMode" to "true" or something simmilar in you X config file. This way 
you can get dri without intel-agp. This is much slower, but enought to play 
tuxracer ;-)

Stefan
