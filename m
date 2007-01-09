Return-Path: <linux-kernel-owner+w=401wt.eu-S1751154AbXAIOL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbXAIOL0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbXAIOL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:11:26 -0500
Received: from il.qumranet.com ([62.219.232.206]:41465 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbXAIOLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:11:25 -0500
Message-ID: <45A3A28B.5000201@qumranet.com>
Date: Tue, 09 Jan 2007 16:11:23 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Stable kvm userspace interface
References: <45A39A97.5060807@qumranet.com> <45A39D0D.7090007@garzik.org>
In-Reply-To: <45A39D0D.7090007@garzik.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Can we please avoid adding a ton of new ioctls?  ioctls inevitably 
> require 64-bit compat code for certain architectures, whereas 
> sysfs/procfs does not.
>

I don't see how the procfs or sysfs models fit kvm.  wrt compat code, 
the current kvm abi (also ioctl based) is 32/64 bit safe without compat 
code, and I certainly don't intend to break it.


-- 
error compiling committee.c: too many arguments to function

