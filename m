Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVL3SaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVL3SaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 13:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVL3SaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 13:30:25 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:6030 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1751276AbVL3SaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 13:30:24 -0500
Date: Fri, 30 Dec 2005 19:30:22 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Mark v Wolher <trilight@ns666.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Message-ID: <20051230183021.GV3105@vanheusden.com>
References: <43B53EAB.3070800@ns666.com>
	<9a8748490512300627w26569c06ndd4af05a8d6d73b6@mail.gmail.com>
	<43B557D7.6090005@ns666.com> <43B5623D.7080402@ns666.com>
	<20051230164751.GQ3105@vanheusden.com> <43B56ADD.7040300@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B56ADD.7040300@ns666.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Dec 31 00:50:14 CET 2005
X-Message-Flag: www.vanheusden.com
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>I'm not sure what to make of this, but it looks like only 1 cpu is kept
> >>>busy with interrupts:
> >>>           CPU0       CPU1       CPU2       CPU3
> >>>  0:    1033372          0          0          0    IO-APIC-edge  timer
> > Install the 'irqbalance' package.
> <..>
> Thanks ! I installed it now, it asked me something about a "one shot
> mode" but i chose no. Correct me if i should choose the other mode.
> Should i reboot for this to take effect ? Cause i still see the 0's
> under the other cpu's.

Not one-shot
reboot? depends on your distribution
try /usr/sbin/irqbalance from bash


Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
