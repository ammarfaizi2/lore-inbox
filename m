Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264864AbUEJQja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264864AbUEJQja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUEJQja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:39:30 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:21257 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264864AbUEJQj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:39:26 -0400
Date: Mon, 10 May 2004 18:39:24 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniele Venzano <webvenza@libero.it>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alex Riesen <ari@mbs-software.de>
Subject: Re: Linux 2.6.6
Message-ID: <20040510163924.GA2560@gateway.milesteg.arr>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Daniele Venzano <webvenza@libero.it>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alex Riesen <ari@mbs-software.de>
References: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org> <20040510105129.GB25969@picchio.gall.it> <Pine.LNX.4.58.0405100810320.3028@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405100810320.3028@ppc970.osdl.org>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 08:11:08AM -0700, Linus Torvalds wrote:
> 
> Can you do the dmesg for 2.6.6 too? Just to see if something else changed? 
> For example, maybe ACPI or something decided to (incorrectly) change your 
> irq..
> 
> 		Linus

Indeed it was ACPI, the patch available here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108415978500425&w=2

made the trick.

Thanks to Alex for the link to the right thread.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

