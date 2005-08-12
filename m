Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVHLTnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVHLTnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVHLTnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:43:15 -0400
Received: from mail.suse.de ([195.135.220.2]:11721 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751262AbVHLTnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:43:13 -0400
Message-ID: <42FCE33F.2060909@suse.de>
Date: Fri, 12 Aug 2005 19:58:23 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [patch] Feature removal: ACPI S4bios support
References: <200508111417.47499.blaisorblade@yahoo.it> <20050812132444.GH1826@elf.ucw.cz>
In-Reply-To: <20050812132444.GH1826@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Remove S4BIOS support. It is pretty useless, and only ever worked for
> _me_ once. (I do not think anyone else ever tried it). It was in

I tried it. It did not work. And IIRC, i once dug through the code paths
and found out, that it could not work, since at least ~2.6.5 (that's
when i looked, the code was broken long before, i assume).

> feature-removal for a long time, and it should have been removed before.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

