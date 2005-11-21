Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVKUS6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVKUS6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVKUS6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:58:48 -0500
Received: from mail.suse.de ([195.135.220.2]:56045 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932452AbVKUS6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:58:48 -0500
Message-ID: <438218E6.4070604@suse.de>
Date: Mon, 21 Nov 2005 19:58:46 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, vda@ilport.com.ua
Subject: Re: Compaq Presario "reboot" problems
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com> <200511181351.41159.vda@ilport.com.ua> <Pine.LNX.4.61.0511180904470.4215@chaos.analogic.com> <200511191644.03330.vda@ilport.com.ua> <Pine.LNX.4.61.0511211246390.14321@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511211246390.14321@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

> I don't know how to make `reboot` or `init 0` take the required
> parameters! I don't know how to get from user-mode into the kernel
> code with any such parameters. I looked through `proc` and couldn't
> find anything for such parameters either:
> 
> Script started on Mon 21 Nov 2005 12:42:11 PM EST
> [root@chaos root]# reboot=cb
> [root@chaos root]# strace reboot=cb
> strace: reboot=cb: command not found
> [root@chaos root]# strace reboot -cb

Pass it to the kernel at the bootloader prompt. Like the "vga=6" and
"root=/foo/bar" you have somewhere in there.

-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
