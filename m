Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVBOGGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVBOGGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 01:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVBOGGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 01:06:01 -0500
Received: from 83-216-143-24.alista342.adsl.metronet.co.uk ([83.216.143.24]:27523
	"EHLO devzero.co.uk") by vger.kernel.org with ESMTP id S261634AbVBOGFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 01:05:51 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 06:05:11 +0000
User-Agent: KMail/1.7.91
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz>
In-Reply-To: <20050214211105.GA12808@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502150605.11683.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 Feb 2005 21:11, Pavel Machek wrote:
[snip]
>
> Table of known working systems:
>
> Model                           hack (or "how to do it")
> ---------------------------------------------------------------------------
>--- IBM TP R32 / Type 2658-MMG      none (1)
> Athlon HP Omnibook XE3		none (1)
> Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
> IBM t41p			none (1)
> Athlon64 desktop prototype	s3_bios (2)
> HP NC6000			s3_bios (2)

The above report is incorrect. On 2.6.11-rc4, even with the s3_bios option, 
the NC6000 (which I own) still does not wake up from S3 sleep. The wiki 
linked somewhere else in this thread also identifies these machines as not 
working.

> Toshiba Satellite 4080XCDT      s3_mode (3)
> Toshiba Satellite 4030CDT	s3_mode (3)
> Dell D600, ATI RV250            vga=normal (**)
> Asus L2400D                     s3_mode (3)(***) (S1 also works OK)
> Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
> Acer TM 800			vga=normal, X patches, see webpage (5)
> Athlon64 Arima W730a		vbestate needed (6)
> eMachines athlon64 machines	vbestate needed (6) (someone please get me
> model #s)
>
> (**) Text console is "strange" after resume. Backlight is switched on again
>
>      by the X server. X server is:
>      | X Window System Version 6.8.1.904 (6.8.2 RC 4)
>      | Release Date: 2 February 2005
>      | X Protocol Version 11, Revision 0, Release 6.8.1.904
>      | Build Operating System: SuSE Linux [ELF] SuSE
>
>      as present in SUSE 9.3preview3.
>
> (***) To be tested with a newer kernel.
>
> (****) Not with SMP kernel, UP only.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
