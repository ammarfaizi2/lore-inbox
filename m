Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945950AbWBCUuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945950AbWBCUuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945951AbWBCUuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:50:16 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:5252 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1945950AbWBCUuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:50:15 -0500
To: Ismail Donmez <ismail@uludag.org.tr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] pktcdvd: Remove version string
References: <m3bqxoci5g.fsf@telia.com> <m37j8cci2r.fsf@telia.com>
	<200602032229.28499.ismail@uludag.org.tr>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Feb 2006 21:49:39 +0100
In-Reply-To: <200602032229.28499.ismail@uludag.org.tr>
Message-ID: <m3hd7gb21o.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ismail Donmez <ismail@uludag.org.tr> writes:

> Cuma 3 Şubat 2006 22:18 tarihinde şunları yazmıştınız:
> > The version information is not useful for a driver that is maintained
> > in Linus' kernel tree.
> >
> > Signed-off-by: Peter Osterlund <petero2@telia.com>
...
> Hmm this is useful to do dmesg|grep pktcdvd though when you compile it in the 
> kernel. So I would like to keep it in.

Why is it useful? The actual version number can't be that useful since
it hasn't been updated since 2004. If you just want to know if the
driver is currently in the kernel, you can do:

        cat /proc/misc | grep pktcdvd

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
