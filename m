Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWCUOck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWCUOck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWCUOck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:32:40 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:20363 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030409AbWCUOcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:32:39 -0500
Message-ID: <44200E84.8090805@garzik.org>
Date: Tue, 21 Mar 2006 09:32:36 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeny Stepanischev <bolk@hitv.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16/piix
References: <506113975.20060321163650@hitv.ru>
In-Reply-To: <506113975.20060321163650@hitv.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.4 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeny Stepanischev wrote:
> Can't run 2.6.16 kernel.
> 
> 
> # make install
> 
> sh /usr/src/linux-2.6.16/arch/i386/boot/install.sh 2.6.16 arch/i386/boot/bzImage System.map "/boot"
> WARNING: No module ata_piix found for kernel 2.6.16, continuing anyway

Your kernel config or something is screwed up, and module ata_piix 
didn't get built...

> Than I reboot I see "can't find superblock: kernel panic"

...thus no driver to read a superblock.

	Jeff


