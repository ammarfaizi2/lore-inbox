Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWEZK3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWEZK3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWEZK3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:29:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:713 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751368AbWEZK3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:29:12 -0400
Message-ID: <4476D874.6060000@garzik.org>
Date: Fri, 26 May 2006 06:29:08 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       gregkh@suse.de, trenn@suse.de,
       joachim deguara <joachim.deguara@amd.com>
Subject: Re: Recent x86-64 patch causes many devices to disappear
References: <4476D020.8070605@garzik.org> <200605261203.55108.ak@suse.de>
In-Reply-To: <200605261203.55108.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The problem is that most people cannot figure out how 
> to disable this in the BIOS so we needed a way to make it boot
> out of the box.

Agreed.


> Booting without PCI-X is better than booting with it.

May I suppose you mean "booting without PCI-X is better than not booting 
at all" ?  Booting with PCI-X is obviously better.


> Maybe we should only do this if PCI segmentation is disabled? 

May I suppose you mean "only do pci=noacpi if PCI segmentation is 
enabled" ?  That was my original proposal in the thread, in fact.....

	Jeff


