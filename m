Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWGPWra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWGPWra (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 18:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWGPWra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 18:47:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40348 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750897AbWGPWr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 18:47:29 -0400
Subject: Re: Linux v2.6.18-rc2
From: David Woodhouse <dwmw2@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060716194134.GB17387@suse.de>
References: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org>
	 <20060716194134.GB17387@suse.de>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 18:45:33 -0400
Message-Id: <1153089953.5491.0.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-16 at 21:41 +0200, Olaf Hering wrote:
> Why does the 'headers_install' target require a configured kernel?
> I just ran 'make headers_install INSTALL_HDR_PATH=/dev/shm/$$'

Sam had a patch to fix that. I think he's already asked Linus to pull
it.

> Unrelated:
> Cant you just export all asm-<arch> files? I guess they are all static. 

$DEITY no. We want the exported set to be as minimal as possible.

-- 
dwmw2

