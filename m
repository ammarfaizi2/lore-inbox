Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266002AbUHMPdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUHMPdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUHMPdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:33:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:47799 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266002AbUHMPdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:33:19 -0400
To: Zhan Rongkai <zhanrk2000@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About the decompression of compressed kernel image
References: <20040813145649.99935.qmail@web61309.mail.yahoo.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm having an emotional outburst!!
Date: Fri, 13 Aug 2004 17:31:27 +0200
In-Reply-To: <20040813145649.99935.qmail@web61309.mail.yahoo.com> (Zhan
 Rongkai's message of "Sat, 14 Aug 2004 00:56:49 +1000 (EST)")
Message-ID: <je1xibdpgw.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhan Rongkai <zhanrk2000@yahoo.com.au> writes:

>     NOTE: The two commands: "gzip -f -9
> arch/$(ARCH)/boot/compressed/vmlinux.bin' and
>     'gzip -f -9 <
> arch/$(ARCH)/boot/compressed/vmlinux.bin >
> arch/$(ARCH)/boot/compressed/vmlinux.bin.gz' ouput two
> copies of 
>     'vmlinux.bin.gz' with different file size. Is it
> ok? Why?

Because the former puts the original name into the output, the latter
can't.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
