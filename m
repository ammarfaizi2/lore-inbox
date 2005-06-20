Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVFTN25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFTN25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVFTN25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:28:57 -0400
Received: from pop.gmx.de ([213.165.64.20]:25045 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261231AbVFTN2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:28:54 -0400
X-Authenticated: #4401329
Message-ID: <42B6C3C0.9010209@gmx.net>
Date: Mon, 20 Jun 2005 15:25:20 +0200
From: Simon Sudler <Simon.Sudler@gmx.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcel Naziri <silent@zwobbl.de>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_promise KERNEL_BUG on 2.6.12
References: <200506200402.55229.silent@zwobbl.de> <42B62901.3000500@pobox.com> <200506201432.30628.silent@zwobbl.de>
In-Reply-To: <200506201432.30628.silent@zwobbl.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm the the problem on my Promise SATAII-150 TX4
with the 2.6.12. However after a immediate downgrade to
2.6.11 the problem persist.
updating the controller bios to 1.00.0.34 didn't helped either.

The kernel freezes the interrupt from the satalib after a short
time. strangly it occurs only after even numbers (like
200000 or 300000). Bevor the freez, all devices are working fine
except for some

[kernel] irq 18: nobody cared!

messages.

Simon
