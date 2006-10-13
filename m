Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWJMXKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWJMXKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWJMXKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:10:11 -0400
Received: from mail.trixing.net ([87.230.125.58]:58842 "EHLO mail.trixing.net")
	by vger.kernel.org with ESMTP id S1751977AbWJMXKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:10:09 -0400
Message-ID: <45301CB3.4060803@l4x.org>
Date: Sat, 14 Oct 2006 01:09:39 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060228 Thunderbird/1.5 Mnenhy/0.6.0.104
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: joro-lkml@zlug.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061010153745.GA27455@zlug.org>	<452FD6F6.3090907@l4x.org>	<20061013191744.GA30089@zlug.org> <20061013.150608.63128976.davem@davemloft.net>
In-Reply-To: <20061013.150608.63128976.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.3
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: Re: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on mail.trixing.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Joerg Roedel <joro-lkml@zlug.org>
> Date: Fri, 13 Oct 2006 21:17:45 +0200
> 
>> On Fri, Oct 13, 2006 at 08:12:06PM +0200, Jan Dittmer wrote:
>>> This is missing the MODULE_LICENSE statements and taints the kernel upon
>>> loading. License is obvious from the beginning of the file.
>  ...
>>> Signed-off-by: Jan Dittmer <jdi@l4x.org>
>> Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>
> 
> Applied, thanks for catching this Jan.
> 

Btw. is there any way to autoload the sit module or is this the
task of the distribution tools? Debian etch at least does not
automatically probe the module when trying to bring up a 6to4 tunnel.

Jan
