Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265281AbUHCL1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbUHCL1B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 07:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUHCL1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 07:27:01 -0400
Received: from host-ip82-243.crowley.pl ([62.111.243.82]:16138 "HELO
	software.com.pl") by vger.kernel.org with SMTP id S265281AbUHCL07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 07:26:59 -0400
From: Karol Kozimor <kkozimor@aurox.org>
Organization: Aurox Sp. z o.o.
To: linux-kernel@vger.kernel.org
Subject: Re: -mm swsusp: do not default to platform/firmware
Date: Tue, 3 Aug 2004 13:28:14 +0200
User-Agent: KMail/1.6.2
References: <20040728222445.GA18210@elf.ucw.cz> <Pine.LNX.4.50.0408012313350.4359-100000@monsoon.he.net> <20040802153021.354C9AF200@voldemort.scrye.com>
In-Reply-To: <20040802153021.354C9AF200@voldemort.scrye.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031328.14595.kkozimor@aurox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 of August 2004 17:30, Kevin Fenzi wrote:
> Patrick> I'd rather leave it, and put pressure on the platform
> Patrick> implementations to be made to work. If you want to shutdown,
> Patrick> then specify it on the command line before you suspend (or
> Patrick> add it to the suspend script).
>
> Does _anyone_ have a machine where platform works?
>
> I can't recally anyone posted on the acpi/swsusp2/kernel lists that
> they had a platform implementation that worked.
>
> Perhaps they had no reason to post? Anyone out there with a laptop
> with a suspend to disk in formware/platform using ACPI that works?
> I'd love to be proven wrong...

I guess you mean most users of the original pmdisk code, as it originally 
defaulted to platform (which in most cases should be ACPI S4). I mean, S4 
is not even remotely as obscure as S3. Then again, S4BIOS or other 
firmware methods are different beasts.

For the reference, original pmdisk code worked fine with platform on my 
laptop the last time I checked (several months ago).

Best regards,
-- 
Karol 'sziwan' Kozimor
kkozimor@aurox.org
