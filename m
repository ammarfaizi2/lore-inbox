Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUK3Vbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUK3Vbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUK3Vbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:31:41 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:4255 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262328AbUK3Vbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:31:31 -0500
Subject: Re: Walking all the physical memory in an x86 system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-os@analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0411302141080.31175@yvahk01.tjqt.qr>
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA977@azsmsx406>
	 <Pine.LNX.4.53.0411301711140.25731@yvahk01.tjqt.qr>
	 <41ACADD3.2030206@draigBrady.com>
	 <Pine.LNX.4.53.0411301832510.11795@yvahk01.tjqt.qr>
	 <1101840619.25609.107.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0411301519130.4393@chaos.analogic.com>
	 <Pine.LNX.4.53.0411302141080.31175@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101846485.25609.173.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 20:28:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 20:46, Jan Engelhardt wrote:
> I want(ed) to find out which I/O port to use for inb() and stuff, and using the
> BIOS's provided data. If you are referring to "ports", I could not find a
> device node, but "port" maybe:

I didn't know that was in the BIOS page. 

> Oh, look what /dev/mem found! (I retried haha)

> So, /dev/mem points to "physical" mem in a sense like DOS has. (Where, the
> BIOS, is blend into, as you can see)

The kernel also preserves the low 4K because some apps, APM and the like
turned out to need it. 


