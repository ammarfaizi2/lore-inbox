Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVH2HVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVH2HVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 03:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVH2HVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 03:21:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23937 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751190AbVH2HVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 03:21:37 -0400
Message-ID: <4312A3B4.4030104@suse.de>
Date: Mon, 29 Aug 2005 07:57:08 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: hch@infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update warnings
References: <20050822081528.GA4418@elf.ucw.cz> <1124753566.5093.8.camel@localhost> <20050823125017.GB3664@elf.ucw.cz> <20050823125724.GA7341@infradead.org> <20050823130050.GB3735@elf.ucw.cz>
In-Reply-To: <20050823130050.GB3735@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> "Known problematic" modules are; be sure to unload them before
> suspend:
> - DRI being used (3D acceleration)

sometimes, not always. Also, this equals "reboot instead of suspend,
please" since if i have to restart X i'd rather reboot instead.
Many people are successfull in using DRI with suspend, even running 3D
Apps while suspend works now. Of course, for troubleshooting it is ok to
keep DRI off the picture, but usually suspend works fine with DRI

> - Firewire
> - SCSI
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

