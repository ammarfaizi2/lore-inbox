Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUHKQdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUHKQdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUHKQdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:33:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:39596 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268107AbUHKQbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:31:20 -0400
Date: Wed, 11 Aug 2004 09:30:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-Id: <20040811093043.522cc5a0@dell_ss3.pdx.osdl.net>
In-Reply-To: <411A478E.1080101@linux.intel.com>
References: <20040714114135.GA25175@elf.ucw.cz>
	<Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com>
	<20040714115523.GC2269@elf.ucw.cz>
	<20040809201556.GB9677@louise.pinerecords.com>
	<Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com>
	<20040810075558.A14154@infradead.org>
	<20040810101640.GF9034@atrey.karlin.mff.cuni.cz>
	<4119F203.1070009@linux.intel.com>
	<20040811114437.A27439@infradead.org>
	<411A478E.1080101@linux.intel.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The driver supports (and defaults to) using firmware_class for loading the 
> firmware.  The driver also supports a legacy loading approach for folks that 
> have problems with using hotplug to load the firmware (which represents a fair 
> number of users).
> 

When and if you submit it into mainline, please remove the legacy loading
approach. Let's get to the cause of the problem and fix it, not bandaid
around it.
