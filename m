Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVBONVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVBONVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVBONUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:20:11 -0500
Received: from 83-216-143-24.alista342.adsl.metronet.co.uk ([83.216.143.24]:46218
	"EHLO devzero.co.uk") by vger.kernel.org with ESMTP id S261717AbVBONSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:18:51 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: Lorenzo Colitti <lorenzo@colitti.com>
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 13:17:15 +0000
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <200502150605.11683.s0348365@sms.ed.ac.uk> <4211E729.1090305@colitti.com>
In-Reply-To: <4211E729.1090305@colitti.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502151317.15633.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 Feb 2005 12:12, Lorenzo Colitti wrote:
> Alistair John Strachan wrote:
> > On Monday 14 Feb 2005 21:11, Pavel Machek wrote:
> >>Table of known working systems:
> >>Model                         hack (or "how to do it")
> >>[...]
> >>HP NC6000   s3_bios (2)
> >
> > The above report is incorrect. On 2.6.11-rc4, even with the s3_bios
> > option, the NC6000 (which I own) still does not wake up from S3 sleep.
> > The wiki linked somewhere else in this thread also identifies these
> > machines as not working.
>
> I beg to differ: it works for me on 2.6.11-rc3 (even with the swsusp2
> patch). However, I need to use acpi_sleep=s3_bios, and I can't use
> radeonfb or it will lock up on resume.
>
> .config attached.
>

As recommended elsewhere in this thread, I'm not using any sort of framebuffer 
driver, but vesafb IS compiled in (but no vga= option is present). Does it 
need to be compiled out completely?

I have acpi_sleep=s3_bios on cmdline. I am not using swsusp2 (and I can't see 
how this is at all related to software suspend).

Perhaps it is the machine BIOS. Which version do you have?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
