Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTGNPYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268476AbTGNPYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:24:23 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:35596 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262577AbTGNPYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:24:16 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Mon, 14 Jul 2003 23:27:33 +0800
User-Agent: KMail/1.5.2
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <200307142318.07232.mflt1@micrologica.com.hk> <20030714163404.A1076@flint.arm.linux.org.uk>
In-Reply-To: <20030714163404.A1076@flint.arm.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307142327.33407.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 July 2003 23:34, Russell King wrote:
> On Mon, Jul 14, 2003 at 11:18:07PM +0800, Michael Frank wrote:
> > Right, using the dword write function for 16 words or so is OK, but
> > rather clumsy for much more than that.
>
> It's config space, that's as good as it gets.
>
> (The last PCI spec I read didn't allow burst accesses to config space,
> and it isn't supposed to be a "memory like" space.)

Time for me to find and read the PCI spec and the PCMCIA spec...
Regards
Michael

-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

