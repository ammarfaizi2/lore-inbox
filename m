Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278646AbRJ0KRG>; Sat, 27 Oct 2001 06:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279141AbRJ0KQ4>; Sat, 27 Oct 2001 06:16:56 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:24996 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S278646AbRJ0KQh>; Sat, 27 Oct 2001 06:16:37 -0400
Subject: Re: Kernel 2.4.13 and ACPI not working (HP Omnibook 6000)
From: Roel Teuwen <Roel.Teuwen@advalvas.be>
To: Rob MacGregor <rob_macgregor@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F59K4GB7DEEbRQwGF5u0001425c@hotmail.com>
In-Reply-To: <F59K4GB7DEEbRQwGF5u0001425c@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 27 Oct 2001 12:27:04 +0200
Message-Id: <1004178427.3496.5.camel@omniroel>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing the exact same problem on my OB 6000, I think it's because
of a buggy bios. I upgraded to the latest version (1.80 [1 okt 2001])
but this doesn't help.

regards,

Roel

On Thu, 2001-10-25 at 14:56, Rob MacGregor wrote:
> System is an HP Omnibook 6000 laptop, using the provided BIOS.  Kernel 
> 2.4.13 with ACPI enabled as a module.
> 
> On boot, with the debug enabled I get:
> 
> tbxface-0107 [01] Acpi_load_tables      : ACPI Tables successfully loaded
> Parsing 
> Methods:............................................................................................................................................................................................................................................................................................................
> 300 Control Methods found and parsed (1046 nodes total)
> ACPI Namespace successfully loaded at root c02d03c0
> ACPI: Core Subsystem version [20010831]
> evregion-0217 [22] Ev_address_space_dispa: no handler for region(c184cea8) 
> [PCIConfig]
> exfldio-0222 [21] Ex_read_field_datum   : Region PCIConfig(2) has no handler
> evregion-0217 [22] Ev_address_space_dispa: no handler for region(c184cea8) 
> [PCIConfig]
> exfldio-0597 [21] Ex_write_field_datum  : **** Region type PCIConfig(2) does 
> not have a handler
> ACPI: Subsystem enable failed
> 
> This is certainly an improvement over previous kernels, however I'd like to 
> get it working.  Any thoughts or is this in the hands of those who 
> understand such things?
> 
> Thanks.
> 
> Oh, I'm not on the list, but I will see any replies on the archive.  If you 
> want a faster response you'll need to CC me.
> 
> --
> Rob  |  Please ask questions the smart way:
>                 http://www.tuxedo.org/~esr/faqs/smart-questions.html
> 
>     Please don't CC me on anything sent to mailing lists or send
>         me email directly unless it's a privacy issue, thanks.
> 
> 
> 
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


