Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVBPPE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVBPPE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVBPPE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:04:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:44223 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262037AbVBPPEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:04:21 -0500
X-Authenticated: #26200865
Message-ID: <42136158.5000906@gmx.net>
Date: Wed, 16 Feb 2005 16:06:00 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger@gmx.at>
CC: acpi-devel@lists.sourceforge.net, Stefan Schweizer <sschweizer@gmail.com>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz> <e796392205021521541da7ee25@mail.gmail.com> <200502160948.43005.stefandoesinger@gmx.at>
In-Reply-To: <200502160948.43005.stefandoesinger@gmx.at>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Dösinger schrieb:
>>The problems with this patch are:
>>- you need to press a key to come back from the "resume-console" after
>>resume. - DRI in X does not work (at least for me with intel-agp, others
>>reportet it works)
>>I just disabloed it by not loading intel-agp (hotplug-blacklist)
> 
> You can force the radeon X driver to use pci mode by setting Option 
> "ForcePciMode" to "true" or something simmilar in you X config file. This way 
> you can get dri without intel-agp. This is much slower, but enought to play 
> tuxracer ;-)

How do I enable DRI with my card to test that crash? I have the
following in my XF86Config:

Section "DRI"
    Group      "video"
    Mode       0660
EndSection

but nothing else about DRI. So do I have to change something in
my configuration?

Oh, and could you please include run "lspci -vv" and include the
part about VGA compatible controller in your mail? I have some
hypothesis about the settings there having to do with resume.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
