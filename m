Return-Path: <linux-kernel-owner+w=401wt.eu-S1161013AbWLTXav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWLTXav (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWLTXav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:30:51 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:26230 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161013AbWLTXau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:30:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ow/hR7h5bM+n2V8kH/44bpfQr96ApVBgZZjTD00h37cJEq0IcM4HzaeK6x/F8oeKrTuyhBAkA6LHRrPUCo6IrRAaQWWT2/sJQBmYi0SIIB7sukBTrnUuY9Hnal57ON3EEFscNEMWSjPdGid6F4gWVTDvb6K2g6RttS6BMdSXvlg=
Message-ID: <1defaf580612201530x4708cc5cs37801bf7d00a598b@mail.gmail.com>
Date: Thu, 21 Dec 2006 00:30:49 +0100
From: "=?ISO-8859-1?Q?H=E5vard_Skinnemoen?=" <hskinnemoen@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch 2.6.20-rc1 0/6] arch-neutral GPIO calls
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>,
       "pHilipp Zabel" <philipp.zabel@gmail.com>
In-Reply-To: <200612201304.03912.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611111541.34699.david-b@pacbell.net>
	 <200612201304.03912.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, David Brownell <david-b@pacbell.net> wrote:
> Based on earlier discussion, I'm sending a refresh of the generic GPIO
> patch, with several (ARM based) implementations in separate patches:
>
>  - Core patch, doc + <asm-arm/gpio.h> + <asm-generic/gpio.h>
>  - OMAP implementation
>  - AT91 implementation
>  - PXA implementation
>  - SA1100 implementation
>  - S3C2410 implementation
>
> I know there's an AVR32 implementation too; and there's been interest
> in this for some PPC support as well.

Great, thanks Dave. Unfortunately, I'm going to be more or less
offline for the rest of the year, but FWIW, the AVR32 implementation
is already in -mm as part of git-avr32.patch. I guess I should check
and see if it's in sync with the rest.

I'll refresh the atmel_spi patch when I get back to work in january.

Haavard
