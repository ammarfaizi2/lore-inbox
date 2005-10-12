Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVJLD7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVJLD7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 23:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVJLD7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 23:59:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:55487 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932405AbVJLD7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 23:59:17 -0400
Subject: Re: info for alc880
From: Lee Revell <rlrevell@joe-job.com>
To: Luca <luca.foppiano@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <460afdfa0510101008v3ad0b914oa2e557b112dde86b@mail.gmail.com>
References: <460afdfa0510101008v3ad0b914oa2e557b112dde86b@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 22:56:36 -0400
Message-Id: <1129085797.7094.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 19:08 +0200, Luca wrote:
> hi, I have a audio card Intel HDA with chipset Realteck ALC880.
> I have kernel 2.6.13.3 and I return this error when the pc start:
> 
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
> hda_codec: Cannot set up configuration from BIOS.  Using 3-stack mode...
> 
> This card is not supported?  I must patch the kernel?

Known problem.  See ALSA bugs 1316, 1429, 1453, and 1460.

(I wish users would check for an existing bug before submitting a new
one...)

Lee

