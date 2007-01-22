Return-Path: <linux-kernel-owner+w=401wt.eu-S1751905AbXAVPJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbXAVPJo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbXAVPJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:09:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53674 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751889AbXAVPJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:09:42 -0500
Date: Mon, 22 Jan 2007 15:18:41 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI seagate.c: remove SEAGATE_USE_ASM
Message-ID: <20070122151841.6d0473e4@localhost.localdomain>
In-Reply-To: <20070121191300.GL9093@stusta.de>
References: <20070121191300.GL9093@stusta.de>
X-Mailer: Claws Mail 2.7.1 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007 20:13:00 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> Using assembler code for performance in drivers might have been a good 
> idea 15 years ago when this code was written, but with today's compilers 
> that's unlikely to be an advantage.
> 
> Besides this, it also hurts the readability.
> 
> Simply use the C code that was already there as an alternative.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
					"stosb\n\t"

NAK

The C codepaths are essentially untested on this driver.

Alan
