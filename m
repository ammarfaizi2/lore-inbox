Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTESRzX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTESRzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:55:23 -0400
Received: from watch.techsource.com ([209.208.48.130]:17051 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S262623AbTESRzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:55:22 -0400
Message-ID: <3EC91F3B.8010005@techsource.com>
Date: Mon, 19 May 2003 14:15:23 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PCI mapping on large memory 32-bit machines
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86 with PAE and 4 gigs of RAM or more, where do memory-mapped I/O 
devices get mapped (in the physical address space)?  Most PCI devices 
can't handle 64-bit addresses.  Can PC chipsets physically remap some of 
the RAM to above 4 gig?  Or do you just lose that much RAM?  If both RAM 
and some I/O device are mapped to the same location, isn't there a conflict?

