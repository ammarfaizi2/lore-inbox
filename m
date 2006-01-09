Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWAITh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWAITh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWAITh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:37:57 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:64425 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1751253AbWAITh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:37:56 -0500
Date: Mon, 9 Jan 2006 20:37:55 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] running tcpdump on 3c905b causes freeze (reproducable)
Message-ID: <20060109193754.GD12673@vanheusden.com>
References: <20060108114305.GA32425@vanheusden.com>
	<20060109041114.6e797a9b.akpm@osdl.org>
	<20060109144522.GB10955@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109144522.GB10955@vanheusden.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Jan 10 20:12:10 CET 2006
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Have you tried enabling the NMI watchdog?  Enable CONFIG_X86_LOCAL_APIC and
> > boot with `nmi_watchdog=1' on the command line, make sure that the NMI line
> > of /proc/interrupts is incrementing.
> I'll give it a try. I've added it to the append-line in the lilo config.
> Am now compiling the kernel.

No change. Well, that is: the last message on the console now is
"setting eth1 to promiscues mode".


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
