Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264710AbUEOQ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264710AbUEOQ4o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264711AbUEOQ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 12:56:44 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:46352 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264710AbUEOQ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 12:56:43 -0400
Date: Sat, 15 May 2004 18:56:41 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: problem with sis900
Message-ID: <20040515165641.GA1608@gateway.milesteg.arr>
Mail-Followup-To: Dominik Karall <dominik.karall@gmx.net>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1084300104.24569.8.camel@datacontrol> <200405132002.56402.dominik.karall@gmx.net> <20040515071233.GB9289@picchio.gall.it> <200405151412.09233.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405151412.09233.dominik.karall@gmx.net>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 02:12:08PM +0200, Dominik Karall wrote:
> But the patch did not apply, so I patched it by hand. To be sure that the file 
> was correctly patched by me, I attached it here.

Applying the patch by hand, you forgot a piece, try to apply the patch
to a clean, unmodified 2.6.6 sis900.c.

Also, did you try to boot with the network cable plugged in ? The
probing code has special case for transciever with link status on.
If you want to try this, please use an unpatched kernel.

Thanks for testing.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

