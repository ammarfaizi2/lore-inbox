Return-Path: <linux-kernel-owner+w=401wt.eu-S1030215AbXAKI0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbXAKI0V (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbXAKI0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:26:21 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:48811 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030215AbXAKI0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:26:20 -0500
Message-ID: <45A5F4A5.9000408@garzik.org>
Date: Thu, 11 Jan 2007 03:26:13 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: kvm-devel@lists.sourceforge.net, Avi Kivity <avi@qumranet.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kvm-devel] [RFC] Stable kvm userspace interface
References: <45A39A97.5060807@qumranet.com> <45A39D0D.7090007@garzik.org> <200701110834.43800.arnd@arndb.de>
In-Reply-To: <200701110834.43800.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Tuesday 09 January 2007 14:47, Jeff Garzik wrote:
>> Can we please avoid adding a ton of new ioctls?  ioctls inevitably 
>> require 64-bit compat code for certain architectures, whereas 
>> sysfs/procfs does not.
> 
> For performance reasons, an ascii string based interface is not
> desireable here, some of these calls should be optimized to
> the point of counting cycles.

sysfs does not require ASCII...

	Jeff



