Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUBHL4E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 06:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUBHL4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 06:56:04 -0500
Received: from smtp04.web.de ([217.72.192.208]:1298 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263491AbUBHL4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 06:56:02 -0500
Message-ID: <402623F2.2020604@web.de>
Date: Sun, 08 Feb 2004 12:56:34 +0100
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: ACPI and APM together?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I have a few machines with pretty similar hardware configuration, but 
they do different tasks for which I need different kernel functionality. 
So far I can have configure the kernel features that I need mostly as 
modules and have on kernel configuration/compilation for all the 
machines except for one. This computer has a motherboard which is some 
older than the oders and doesn't reboot/halt properly with ACPI, it 
definitely needs APM. So the question is, if it would be possible to 
compile both ACPI and APM into the kernel and pass the corsponding 
parameters acpi=off or apm=off where it is appropriate? I looked through 
the kernel help and docs, but they say only, that the kernel would use 
whichever is loaded first... Nowhere is anything mentined, if one could 
proactively influence the decision.
Any help/answer would be very appreciated. TIA

Regards,
Todor
