Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVE0Ukn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVE0Ukn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVE0Ukn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:40:43 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51936 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262582AbVE0Uk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:40:27 -0400
Message-ID: <429785B5.6020705@pobox.com>
Date: Fri, 27 May 2005 16:40:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Chan <mchan@broadcom.com>
CC: "David S. Miller" <davem@davemloft.net>, linville@tuxdriver.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
References: <04132005193844.8474@laptop> <20050421165956.55bdcb14.davem@davemloft.net> <20050527184750.GB11592@tuxdriver.com> <20050527.123037.68041200.davem@davemloft.net> <1117221859.4310.6.camel@rh4>
In-Reply-To: <1117221859.4310.6.camel@rh4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Chan wrote:
> On Fri, 2005-05-27 at 12:30 -0700, David S. Miller wrote:
> 
> 
>>I'll apply this, thanks John.
>>
>>pci.ids needs several updates for tg3 in fact, and it
>>also now needs entries for bnx2 as well.
>>
> 
> 
> The bnx2 IDs are already in, probably from sourceforge. And the tg3 IDs
> look reasonably complete to me.
> 
> So in the future, do we need to patch this file or just let sourceforge
> take care of it?

Honestly, pci.ids is such a non-critical file, unless DaveM disagrees I 
would strongly encourage people to -only- send pci.ids updates to 
sourceforge.

pci.ids is only used in one location -- deprecated /proc/pci -- and will 
be removed in the next year or so, I imagine. Further, pci.ids is 
periodically sync'd en masse from sourceforge into the kernel by janitors.

Users should be using 'lspci' not /proc/pci, and lspci takes it data 
from sourceforge database not the kernel.

	Jeff


