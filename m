Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289148AbSAQPSt>; Thu, 17 Jan 2002 10:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSAQPS3>; Thu, 17 Jan 2002 10:18:29 -0500
Received: from trained-monkey.org ([209.217.122.11]:28173 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S289139AbSAQPS0>; Thu, 17 Jan 2002 10:18:26 -0500
From: Jes Sorensen <jes@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15430.60214.968250.153045@trained-monkey.org>
Date: Thu, 17 Jan 2002 10:18:14 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <Pine.LNX.4.33.0201171556060.19753-100000@chaos.tp1.ruhr-uni-bochum.de>
In-Reply-To: <15430.55835.417188.484427@trained-monkey.org>
	<Pine.LNX.4.33.0201171556060.19753-100000@chaos.tp1.ruhr-uni-bochum.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kai" == Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> writes:

Kai> On Thu, 17 Jan 2002, Jes Sorensen wrote:
>>  The problem is that the interrupt is not set in the PIRQ table so if
>> we don't shoehorn it in, the interrupt source wont be found.

Kai> Is the interrupt in the ACPI PCI IRQ routing table? Basic support
Kai> for that is in the latest ACPI patch, 20011218
Kai> (www.sf.net/projects/acpi), it'll print the _PRT entries during
Kai> boot. However, the info isn't used to actually setup the routing,
Kai> so it won't help your problem. I have a patch which uses the ACPI
Kai> table for setting up IRQ routing, that should make sure system work
Kai> properly.

I think it's in the ACPI table since a certain M$ OS finds the interrupt
source. As I mentioned to Alan, I tried the latest ACPI patch but as you
say, nothing is done with the information. I haven't tried enabling
ACPI_DEBUG but that sounds to be a next step.

I'd be interested in trying out your patch as well.

Cheers,
Jes
