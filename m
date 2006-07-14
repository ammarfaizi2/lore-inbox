Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWGNQpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWGNQpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbWGNQpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:45:53 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:5350 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1422636AbWGNQpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:45:52 -0400
Message-ID: <44B7CBA8.9010507@gentoo.org>
Date: Fri, 14 Jul 2006 17:51:52 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       greg@kroah.com, harmon@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org> <20060714154240.GA23480@tuatara.stupidest.org> <44B7C37F.1050400@gentoo.org> <44B7C521.5080009@gentoo.org> <20060714163351.GA24377@tuatara.stupidest.org>
In-Reply-To: <20060714163351.GA24377@tuatara.stupidest.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Fri, Jul 14, 2006 at 05:24:01PM +0100, Daniel Drake wrote:
> 
>> are XT-PIC). I cannot enable APIC on this system due to buggy BIOS.
>                                ^^^^
> 
> IO-APIC you mean?

Yes.

> what system have you got there?

Abit KX7-333 (VIA Apollo KT266/A/333).

I also tried disabling ACPI completely, and the system booted without 
the quirk applied. I was of the suspicion that if I could get IO-APIC 
enabled, then the system would be unable to boot, but this is only 
guesswork based on the info in the Gentoo bug report.

Perhaps we can discount my system, but Aiko Barz's case from the Gentoo 
bug should definitely be considered: Without ACPI, the quirk is not 
needed. With ACPI, the quirk is needed.

Daniel
