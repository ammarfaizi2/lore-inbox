Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbUKOSEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUKOSEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 13:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUKOSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 13:04:55 -0500
Received: from mail.aknet.ru ([217.67.122.194]:44305 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261656AbUKOSEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 13:04:53 -0500
Message-ID: <4198EFE5.5010003@aknet.ru>
Date: Mon, 15 Nov 2004 21:05:25 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Maciej W. Rozycki wrote:
> This has been verified to work correctly with your configuration.  
Thanks, it works indeed.
But there is still something strange.
Previously, in 2.6.10-rc1 (and in -mm2
either I think) the NMI watchdog was
working in both LAPIC and IO-APIC modes.
Now - only in LAPIC mode.
nmi_watchdog=1 still doesn't work.
Any ideas about this?
Just trying to make sure that everything
is correct.
And btw, dmesg is still silent about a
LAPIC. This makes me nervous when I am
trying to figure out whether it works or
not:) Would be nice to get those prominent
messages back, as per 2.6.8.

