Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966618AbWKOBe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966618AbWKOBe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 20:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966619AbWKOBe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 20:34:58 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:45529 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966618AbWKOBe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 20:34:58 -0500
Message-ID: <455A6EBF.7060200@garzik.org>
Date: Tue, 14 Nov 2006 20:34:55 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <200611150059.kAF0xBTl009796@hera.kernel.org>
In-Reply-To: <200611150059.kAF0xBTl009796@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit 134a11f0c37c043d3ea557ea15b95b084e3cc2c8
> tree c23bfd643913ea2d8cd01b17c1572b9602de7fd5
> parent c387fd85f84b9d89a75596325d8d6a0f730baf64
> author Takashi Iwai <tiwai@suse.de> 1163156917 +0100
> committer Linus Torvalds <torvalds@woody.osdl.org> 1163549067 -0800
> 
> [PATCH] ALSA: hda-intel - Disable MSI support by default
> 
> Disable MSI support on HD-audio driver as default since there are too
> many broken devices.
> 
> The module option is changed from disable_msi to enable_msi, too.  For
> turning MSI support on, pass enable_msi=1, instead.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:(  Like AHCI, PCI MSI has -always- worked wonderfully for HD audio AFAIK.

Is a whitelist patch forthcoming?

	Jeff


