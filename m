Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUJDUCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUJDUCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUJDUCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:02:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:34268 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267986AbUJDUCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:02:13 -0400
Date: Mon, 4 Oct 2004 12:59:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: eyal@eyal.emu.id.au, linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: 2.6.9-rc3-mm2: error: `u64' used prior to declaration
Message-Id: <20041004125937.7836e605.akpm@osdl.org>
In-Reply-To: <20041004153515.GB12736@stusta.de>
References: <416160FE.2090107@eyal.emu.id.au>
	<20041004153515.GB12736@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
>  Would you accept a patch that changes all #include <asm/bitops.h> to
>  #include <linux/bitops.h> ?

I have an easier solution - I'll drop

add-rotate-left-right-ops-to-bitopsh.patch
add-rotate-left-right-ops-to-bitopsh-build-fix.patch
sha512-use-asm-optimized-bit-rotation.patch
