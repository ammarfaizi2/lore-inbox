Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266408AbUAOCjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266410AbUAOCjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:39:24 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:21154 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S266408AbUAOCjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:39:13 -0500
Subject: Re: Serial ATA (SATA) for Linux status report
From: Matthias Hentges <mailinglisten@hentges.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4005D9E7.2070203@bigfoot.com>
References: <20031203204445.GA26987@gtf.org>
	 <87hdyyxjgl.fsf@stark.xeocode.com> <20040114225653.GA32704@codepoet.org>
	 <4005D195.3010008@inp-net.eu.org>  <4005D9E7.2070203@bigfoot.com>
Content-Type: text/plain
Organization: 
Message-Id: <1074134345.6094.11.camel@mhcln02>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Jan 2004 03:39:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Am Don, 2004-01-15 um 01.08 schrieb Erik Steffl:
> Raphael Rigo wrote:
> ...<ICH5problems snipped>...
> > One possible workaround it to enable both PATA and SATA drivers (using 
> > libata) and pass "ide2=noprobe ide3=noprobe" to kernel at boot.
> > More detailled answer can be found here : 
> > http://www.hentges.net/howtos/p4p800_deluxe.html
> 
>    I have pretty much the same setup he recommends in UPDATE except of 
> the "ide2=noprobe ide3=noprobe" kernel boot options, not sure why would 
> that be needed but my system (interl D865PERL, cd burner, ide and sata 
> disks) works OK without it.

The "Update" section describes the setup which - after *weeks* of
frustrating trail-and-error - managed to get things going.

Notice the unusual BIOS setting (Enhanced Mode - SATA only) which did
the trick and enabled PATA *and* SATA.
You may want to try that if you haven't already.

The ideN=noprobe my indeed not be necessary . It was recommended by Jeff
Garzik to me at some time IIRC. Kernel 2.6 does *not* need the noprobe
stuff AFAICT.

FWIW my P4P800 Deluxe is working flawlessly with 4 P-ATA devices (2 HDs,
a ZIP100 and a 48x Burner) and one SATA 160Gb HD.

I'm using 2.4.22-bk36 with matching libata patch so i'd think that any
kernel 2.4.23+ will do the trick.

HTH and GL
-- 

Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody. Geek by Nature, Linux by Choice

