Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTHZGMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 02:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbTHZGMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 02:12:31 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:17674 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263538AbTHZGM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 02:12:29 -0400
Message-ID: <3F4AF755.2000407@boxho.com>
Date: Tue, 26 Aug 2003 01:59:49 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rod Bacon <rodb@jasco.net.au>
Subject: Re: ERROR: Broken Via-Rhine NIC In "Stable" 2.4.22
References: <sf4b7a30.018@jchofs1.jasco.net.au>
In-Reply-To: <sf4b7a30.018@jchofs1.jasco.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw that same message in 2.6.0-t3. Sometimes immediately the netcard 
would not ping
and sometimes it would fail after a while.

Do you see an "irq ? disabled" message, too? That would be typical.

Try turning apic off in bios-cmos-setup and letting linux turn it on. I 
don't have to use drastic
pci=noacpi, I can just disable serial and parallel and USB and turn apic 
off in bios and run
with no cd drives. Easier for me.

-Bob

Rod Bacon wrote:

>Just attempted upgrade from 2.4.21 on a Via M10000 Mini-ITX system that
>was working perfectly. 2.4.22 results in eth0 not working, and constant
>"NETDEV WATCHDOG: eth0: transmit timed out. Resetting".
>  
>

