Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVAJO7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVAJO7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 09:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVAJO7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 09:59:18 -0500
Received: from ns.lbox.cz ([62.129.50.35]:21692 "EHLO ns.lbox.cz")
	by vger.kernel.org with ESMTP id S262285AbVAJO7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 09:59:15 -0500
Subject: Re: Re: Support for > 2GB swap partitions?
From: Nikola Ciprich <extmaillist@linuxbox.cz>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501100504460.27243@p500>
References: <Pine.LNX.4.61.0501091933090.29064@p500>
	 <Pine.LNX.4.60.0501100142070.27893@alpha.polcom.net>
	 <Pine.LNX.4.61.0501100504460.27243@p500>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 15:59:03 +0100
Message-Id: <1105369143.3629.2.camel@develbox.linuxbox.cz>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Antivirus: scanned on linuxbox by AVP 5.0 (aveserver), data 101033 records (22-10-2004)
X-Spam-Razor: N/A
X-Spam-Score: N/A (whitelist)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the reason is, that fdisk did set swap partition, but it did not set
swap header as it's not its task (as is not creating filesystems).
mkswap must be always used while creating new swap partitions/files.

On Mon, 2005-01-10 at 05:09 -0500, Justin Piszcz wrote:
> Oops, for some reason when I created the partitions with fdisk it did not 
> create the swap parititon correctly even though I specified it was type 
> swap.  mkswap /dev/sda2 && swapon /dev/sda2 fixed the problem, thanks.
> 


