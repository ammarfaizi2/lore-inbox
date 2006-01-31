Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWAaLFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWAaLFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 06:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAaLFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 06:05:52 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:64157 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750755AbWAaLFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 06:05:51 -0500
Message-ID: <43DF441E.4040304@t-online.de>
Date: Tue, 31 Jan 2006 12:03:58 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [BUG] 8139too fails for ip autoconfig and nfsroot
References: <43DE7035.1040806@t-online.de>
In-Reply-To: <43DE7035.1040806@t-online.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: SrXymMZX8ec3e8BnbOVtGQrLonl9BjgiLuxuVv0g1Wh08x7PK4VV0k@t-dialin.net
X-TOI-MSGID: 890b1471-7e9e-4209-bfdc-accfd485470c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:

> but found none. Skipping ip autoconfig is no solution, the kernel then 
> fails trying rpc lookup.
>
> Then I tried to netboot another system with the same kernel + via 
> rhine driver, same server
> config. Voila, dhcp ip autoconfig and rpc port lookup is not a problem 
> on this system.
>
> During my search for a solution I tried some recent kernels, the 
> oldest 2.6.14. All fail with 8139too.
>
> Any ideas?
>
It does work now. How?

I enabled  "Use PIO instead of MMIO". Everything started to work.
I disabled "Use PIO instead of MMIO" and enabled "Use older RX-reset 
method".
Everything still fine.

The crazy thing is that it does work now even with both of the options 
disabled.
It does work even after complete power removal for several hours.

cu,
 Knut
