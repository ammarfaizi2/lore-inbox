Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVIJXf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVIJXf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVIJXfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:35:25 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44438 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932257AbVIJXfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:35:25 -0400
Message-ID: <43236DAE.8000802@pobox.com>
Date: Sat, 10 Sep 2005 19:35:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Greg KH <greg@kroah.com>, Jiri Slaby <jirislaby@gmail.com>,
       Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] include: pci_find_device remove (include/asm-i386/ide.h)
References: <200509102032.j8AKWxMC006246@localhost.localdomain> <4323482E.2090409@pobox.com> <20050910211932.GA13679@kroah.com> <432352A8.3010605@pobox.com> <20050910223333.GF4770@parisc-linux.org>
In-Reply-To: <20050910223333.GF4770@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Sat, Sep 10, 2005 at 05:39:52PM -0400, Jeff Garzik wrote:
> 
>>Look at what the IDE code is trying to do.  All it cares about is 
>>whether -any PCI device at all- is present, a boolean value.
> 
> 
> Why not change it to query whether any IDE device is present, perhaps
> using pci_get_class()?

Because that's not what the code is attempting to discover.

	Jeff



