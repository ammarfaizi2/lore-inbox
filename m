Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUGEKCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUGEKCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 06:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUGEKCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 06:02:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:63455 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265983AbUGEKCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 06:02:31 -0400
Date: Mon, 5 Jul 2004 12:02:15 +0200
From: Olaf Hering <olh@suse.de>
To: adaplas@pol.net
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.7-bk16, mode-switch-in-fbcon_blank.patch breaks X on r128
Message-ID: <20040705100215.GA28834@suse.de>
References: <20040704160358.GA20970@suse.de> <20040704164037.GA18255@middle.of.nowhere> <20040704171028.GA22469@suse.de> <200407050638.00307.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407050638.00307.adaplas@hotpop.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jul 05, Antonino A. Daplas wrote:

> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> 
> Ugly workaround. ??When switching from KD_GRAPHICS to KD_TEXT, the 
> event is captured at fbcon_blank() allowing fbcon to reinitialize the hardware.
> However, some hardware requires the reinitialization to be done immediately,
> others require it to be done later. ??Others may need it to be done immediately
> and later, this is the worst case. 

This patch fixes it, tested on a ibook g4 with radeon card and
2.6.7-bk17


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
