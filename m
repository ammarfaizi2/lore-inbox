Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbUDHJJG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 05:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264224AbUDHJJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 05:09:06 -0400
Received: from village.ehouse.ru ([193.111.92.18]:44297 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264222AbUDHJJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 05:09:00 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.X kernel memory leak? (was: Re: 2.6.1 IO lockup on SMP systems)
Date: Thu, 8 Apr 2004 13:08:43 +0400
User-Agent: KMail/1.6
Cc: Anton Kovalenko <anton@megashop.ru>
References: <200401311940.28078.rathamahata@php4.ru> <20040226120310.037a6702.akpm@osdl.org> <200402281756.08260.rathamahata@php4.ru>
In-Reply-To: <200402281756.08260.rathamahata@php4.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404081308.43056.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Saturday 28 February 2004 17:56, Sergey S. Kostyliov wrote:
> On Thursday 26 February 2004 23:03, Andrew Morton wrote:
> <cut>
> > OK, thanks.  Is there any possibility that you can run without iptables for
> > a while, see if that fixes it?
> 
> I recompiled 2.6.3 without iptables support, unfortunately it doesn't
> solve the problem, machine still hangs.

It looks like problem hasn't gone away in the last kernels. The visible
symptoms haven't changed: machine is pingable, tcp ports which were in
LISTEN state remains to be in LISTEN after lockup, nothing else.

The last one is for different machine than in my previous reports,
so I suspect this is not a hardware issue. Kernel is 2.6.5-aa3 but
I believe Andrea's changes is not related to this problem.

sysrq-M
	http://sysadminday.org.ru/2.6.X-lockup/terror/20040408/sysrq-M

sysrq-T
	http://sysadminday.org.ru/2.6.X-lockup/terror/20040408/sysrq-T

.config
	http://sysadminday.org.ru/2.6.X-lockup/terror/.config

`lspci -vv'
	http://sysadminday.org.ru/2.6.X-lockup/terror/lspci_-vv

`dmesg'
	http://sysadminday.org.ru/2.6.X-lockup/terror/dmesg

/etc/fstab
	http://sysadminday.org.ru/2.6.X-lockup/terror/fstab


-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
