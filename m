Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268623AbUHLROH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268623AbUHLROH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268624AbUHLROH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:14:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52947 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268623AbUHLROE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:14:04 -0400
Message-ID: <411BA54E.1080105@pobox.com>
Date: Thu, 12 Aug 2004 13:13:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <411BA0F4.9060201@pobox.com> <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Let's see now:
> 
> 	brw-rw----    1 root     disk       3,   0 Jan 30  2003 /dev/hda
> 
> would you put people you don't trust with your disk in the "disk" group?
> 
> Right. If you trust somebody enough that you give him write access to the 
> disk, then you might as well trust him enough to do commands on it. 


Yeah, I agree.  I was thinking write access to files on a hard drive, 
not write access to the blkdev itself.

	Jeff


