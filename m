Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265793AbUFDPvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265793AbUFDPvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbUFDPvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:51:13 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:23567 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265793AbUFDPvE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:51:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Anupam Kapoor <anupam.kapoor@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: lotsa oops - 2.6.5 (preempt + unable handle virutal address +    more?)
Date: Fri, 4 Jun 2004 14:50:10 +0300
X-Mailer: KMail [version 1.4]
References: <E1BW7gZ-00066c-00@mail.kbs.net.au> <87fz9b96ua.fsf@seldon.vxindia.veritas.com>
In-Reply-To: <87fz9b96ua.fsf@seldon.vxindia.veritas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406041450.10360.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 09:26, Anupam Kapoor wrote:
> looks like you are using nvidia ?

several oopses are marked as "Not tainted".

Anyway, your hardware might be flakey.

Run memtest86 overnight and some of
cpuburn tools too. Do heavy PCI traffic
(dd your disk to /dev/null, flood
your ethernet, etc).

Underclock your system and/or set lower
IDE DMA mode and see whether it stops oopsing.
--
vda
