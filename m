Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263612AbUEWVcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUEWVcu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUEWVcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:32:50 -0400
Received: from mail.tpgi.com.au ([203.12.160.53]:46998 "EHLO mail5.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263612AbUEWVcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:32:48 -0400
Message-ID: <40B1174E.6060904@linuxmail.org>
Date: Mon, 24 May 2004 07:27:42 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
References: <20040521100734.GA31550@elf.ucw.cz>	<20040521162044.7ad42db2.akpm@osdl.org>	<20040523175444.GE804@elf.ucw.cz> <20040523130809.03ca7209.akpm@osdl.org>
In-Reply-To: <20040523130809.03ca7209.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> +#if defined(CONFIG_PM_DISK) || defined(CONFIG_SOFTWARE_SUSPEND)

Okay. So I'll just patch it to add || defined(CONFIG_SOFTWARE_SUSPEND2) 
for now :>

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable 
events occur
with alarming frequency, order arises from chaos, and no one is given 
credit.
