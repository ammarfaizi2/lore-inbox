Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVCCRvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVCCRvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVCCRuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:50:18 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:19690 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262531AbVCCRtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:49:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WIlqTwRxXyxtNCjAIscg3x58cLNWcfmrQAahxuSApYI2Ml+McG304PyhFM6ulGRt3ToE40LZSnKysGESLmRAKXw7KGcvYh5MVsTWgNdRcGaP12ENbrHPpbivt3EHIp7RygUkeuzq/Ryz1lBzhvVZZnRV8cXXvPG+zk5sitbgYIA=
Message-ID: <3aa654a405030309493236ec34@mail.gmail.com>
Date: Thu, 3 Mar 2005 09:49:29 -0800
From: Avuton Olrich <avuton@gmail.com>
Reply-To: Avuton Olrich <avuton@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Call for help: list of machines with working S3
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
In-Reply-To: <20050214211105.GA12808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050214211105.GA12808@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2005 22:11:05 +0100, Pavel Machek <pavel@suse.cz> wrote:
> Table of known working systems:
> 
> Model                           hack (or "how to do it")
> ------------------------------------------------------------------------------
> IBM TP R32 / Type 2658-MMG      none (1)
> Athlon HP Omnibook XE3          none (1)
> Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
> IBM t41p                        none (1)
> Athlon64 desktop prototype      s3_bios (2)
> HP NC6000                       s3_bios (2)
> Toshiba Satellite 4080XCDT      s3_mode (3)
> Toshiba Satellite 4030CDT       s3_mode (3)
> Dell D600, ATI RV250            vga=normal (**)
> Asus L2400D                     s3_mode (3)(***) (S1 also works OK)
> Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
> Acer TM 800                     vga=normal, X patches, see webpage (5)
> Athlon64 Arima W730a            vbestate needed (6)
> eMachines athlon64 machines     vbestate needed (6) (someone please get me model #s)
> 
> (**) Text console is "strange" after resume. Backlight is switched on again
>      by the X server. X server is:
>      | X Window System Version 6.8.1.904 (6.8.2 RC 4)
>      | Release Date: 2 February 2005
>      | X Protocol Version 11, Revision 0, Release 6.8.1.904
>      | Build Operating System: SuSE Linux [ELF] SuSE
>      as present in SUSE 9.3preview3.
> 
> (***) To be tested with a newer kernel.
> 
> (****) Not with SMP kernel, UP only.

Toshiba Libretto L5 works completely with S3, not with S1 when the
ali5451 ALSA module is unloaded.

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
