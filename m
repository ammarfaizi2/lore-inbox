Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275435AbTHIXY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 19:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275436AbTHIXY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 19:24:57 -0400
Received: from mail.wlanmail.com ([194.100.155.139]:6662 "HELO
	mail.wlanmail.com") by vger.kernel.org with SMTP id S275435AbTHIXY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 19:24:56 -0400
From: Joonas Koivunen <rzei@mbnet.fi>
Reply-To: rzei@mbnet.fi
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Subject: Re: [BUG?] 2.6.0-test3 USB mouse problems
Date: Sun, 10 Aug 2003 02:24:25 +0300
User-Agent: KMail/1.5.1
References: <200308091506.20935.rzei@mbnet.fi> <200308091808.34884.rzei@mbnet.fi> <200308091803.00289.schlicht@uni-mannheim.de>
In-Reply-To: <200308091803.00289.schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308100224.28641.rzei@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 August 2003 19:02, Thomas Schlichter wrote:
> It's not a problem with ACPI, it's more a problem with the interrupt
> routing based on the ACPI tables. These tables seem to be not correctly
> implemented in the BIOS and, as the german EPOX support admits, are not
> really tested. To change this you may contact the EPOX support and describe
> your problems, too....
Thanks for letting me know.. I had a image of EPOX being pretty good with 
motherboards.. Guess not then.

> If you want to use ACPI while this BIOS bug is not fixed you may use the
> attached patch and boot with pci=noacpi. Without the patch this doesn't
> work for me here...
Why isn't this patch in the mainstream kernel? There are many other 
chipset/bios fixes in the kernel.. This would save many 
reboot/recompilings/worries until or if ever epox does something with the 
bios.

The patch works nicely. Though I did apply it manually to -test3 :) But it 
works.


> Best regards
>   Thomas Schlichter

Thanks again
-rzei
