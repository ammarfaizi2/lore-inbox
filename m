Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266617AbUFVGVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUFVGVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 02:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUFVGVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 02:21:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54674 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266617AbUFVGVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 02:21:01 -0400
Message-ID: <40D7CFBC.30706@pobox.com>
Date: Tue, 22 Jun 2004 02:20:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] iSeries virtual i/o sysfs files
References: <20040622140405.4cb6f8e1.sfr@canb.auug.org.au>
In-Reply-To: <20040622140405.4cb6f8e1.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi all,
> 
> This patch is to elicit comments (hopefully constructive).
> 
> OK, this is what the patch does.  All the iSeries virtual devices now
> appear in /sys/devices/vio and /sys/bus/vio/devices.  Unfortunately,
> apart from the veth devices, there are all possible devices there at
> the moment - I need to think about how to reduce it but that requires
> moving all the probe code into vio.c ...

I'm not sure I entirely parse the third sentence in this paragraph, but 
nonetheless...

My general idea was that vio should be presented as a bus, so that 
userland could enumerate all vio devices.  This approach seems along 
these lines, and I have no objections to the patch.

	Jeff


