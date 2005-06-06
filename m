Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVFFNc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVFFNc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 09:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVFFNcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 09:32:05 -0400
Received: from pop.gmx.net ([213.165.64.20]:48772 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261409AbVFFNbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 09:31:49 -0400
X-Authenticated: #14776911
From: Stefan =?utf-8?q?D=C3=B6singer?= <stefandoesinger@gmx.at>
To: acpi-devel@lists.sourceforge.net
Subject: Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM)
Date: Mon, 6 Jun 2005 15:31:40 +0000
User-Agent: KMail/1.7.2
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org
References: <200506051456.44810.hugelmopf@web.de> <1118053578.6648.142.camel@tyrosine> <1118056003.6648.148.camel@tyrosine>
In-Reply-To: <1118056003.6648.148.camel@tyrosine>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506061531.41132.stefandoesinger@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 6. Juni 2005 11:06 schrieb Matthew Garrett:
> Whoops. May have been a bit too hasty there. I'm not sure why that
> doesn't reset it, but we've now got the following (really rather odd)
> serial output. Does anyone have any idea what might be triggering this?
> Shell builtins work fine, but anything else seems to explode very
> messily. Memory corruption of some description?

<snip>
So it does reach the kernel, right? I don't know if I remembered that call 
correctly, but "lcall $0xffff,$0" should call the real mode BIOS reset 
code...
Anyone else who can correct me here?

Perhaps the disk driver is going mad? Has anyone tried to boot a kernel 
without any disk drivers with a minimal root system on an initrd?

Cheers,
Stefan
