Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVAQWaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVAQWaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbVAQWZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:25:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:9098 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262935AbVAQWEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:04:48 -0500
Subject: Re: [UPDATE] Severe performance problems with kernel 2.6.10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gabriel Tataranu <tgabi@belent.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41EC1721.8080405@belent.com>
References: <41EC1721.8080405@belent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105995611.16119.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 21:00:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-17 at 19:50, Gabriel Tataranu wrote:
> For those interested:
> 
> The performance issues (below) where due to a strange bug in the kernel
> VM triggered by the motherboard BIOS. This affects Asus P4P800
> motherboards(-MX and -VM tested) with more that 1 GB RAM. The built-in
> VGA can use 1-32 MB RAM for display but configured with less than 16 MB
> of video RAM the board will behave EXTREMELY poor in linux (2.6.9 also
> tested to behave like this).

I'll take a guess. Can you send me the boot dmesg and /proc/mtrr of both
the slow and the normal cases. I think I know what the BIOS is doing and
I've been looking for a system doing this so I can find a
vict^H^H^Holunteer to test some ideas out.

Alan

