Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTJXBTh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 21:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTJXBTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 21:19:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261928AbTJXBTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 21:19:35 -0400
Message-ID: <3F987E18.9080606@pobox.com>
Date: Thu, 23 Oct 2003 21:19:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
References: <Pine.LNX.4.44.0310231541000.3421-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310231541000.3421-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> [ Jeff: is that PCI ROM enable _really_ that complicated? Ouch. Or is
>   there some helper function I missed? ]


The mechanics aren't complicated, but I seem to recall there being a 
Real Good Reason why you want to leave it disabled 99% of the time.  No, 
I don't recall that reason :(  But my fuzzy memory seems to think that 
"enable, grab a slice o 'rom, disable" was viable.

	Jeff



