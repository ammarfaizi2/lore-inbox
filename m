Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVHMQFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVHMQFO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVHMQFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:05:14 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:33442 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751346AbVHMQFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:05:13 -0400
From: Grant Coady <Grant.Coady@gmail.com>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
Date: Sun, 14 Aug 2005 02:04:59 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <d86sf15b5b36ta7rgkjo2p980fku9e0lce@4ax.com>
References: <200508131710.38569.annabellesgarden@yahoo.de>
In-Reply-To: <200508131710.38569.annabellesgarden@yahoo.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2005 17:10:38 +0200, Karsten Wiese <annabellesgarden@yahoo.de> wrote:

>Hi,
>
>this fixes the 'doubled ioapic level interrupt rate' issue I've been
>seeing on a K8T800/AMD64 mainboard.
>It also switches off quirk_via_irq() for the VT8237 southbridge.

I'm tracking a dataloss on box with this chip, finding it difficult 
to nail a configuration that reliably produces dataloss, sometimes 
only one bit (e.g. 'c' --> 'C') of unpacking kernel source tree gets 
changed.

Relevant?  This is on a KM400 with Skt A Sempron + Seagate SATA HDD.
http://bugsplatter.mine.nu/test/linux-2.6/sempro/

Thanks,
Grant.

