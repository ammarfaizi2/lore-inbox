Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263773AbREYPpi>; Fri, 25 May 2001 11:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263778AbREYPpS>; Fri, 25 May 2001 11:45:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18959 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263773AbREYPpI>; Fri, 25 May 2001 11:45:08 -0400
Subject: Re: [PATCH] warning fixes for 2.4.5pre5
To: richbaum@acm.org (Rich Baum)
Date: Fri, 25 May 2001 16:42:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <873E21525C8@coral.indstate.edu> from "Rich Baum" at May 24, 2001 09:40:11 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153Jj8-0006gy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> statements and extra tokens at the end of #endifs.  The patch for 
> linux/drivers/usb/pwc-uncompress.c adds includes to fix warnings where 
> kmalloc(), kfree(), and  EXPORT_SYMBOL_NONVERS() implicity declared.

The pwc-uncompress stuff wants ignoring and the -ac fixes picking up that
also clean up the other bits. I'll send that to Linus shortly

