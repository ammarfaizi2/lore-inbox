Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVBDVTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVBDVTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbVBDVMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:12:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48105 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S266177AbVBDVHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:07:34 -0500
Message-ID: <4203E3FE.2090806@pobox.com>
Date: Fri, 04 Feb 2005 16:07:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maxer <maxer@xmission.com>
CC: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: SysKonnect sk98lin Gigabit lan missing in action from 2.6.10
 on
References: <42038994.20401@xmission.com>
In-Reply-To: <42038994.20401@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maxer wrote:
> What is the status of sk98lin? Do we have to wait until Syskonnect gets 
> their act together
> and write a new driver for 2.6.10?
> 
> Their latest is Oct 2004 and not at all compatible with 2.6.10 and beyond.

I've been telling SysKonnect for _years_ that they need to split up 
their patches, but they still keep sending ever-larger jumbo driver 
update patches.

Stephen Hemminger split up their patch into a bunch of patches, and I 
applied several of those.

Apparently, Stephen also got sick of trying to patch and clean sk98lin, 
so he went and wrote his own "skge" driver.  It's available in my 
netdev-2.6 queue, and should be in the latest -mm.

	Jeff



