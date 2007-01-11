Return-Path: <linux-kernel-owner+w=401wt.eu-S1030208AbXAKIDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbXAKIDu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbXAKIDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:03:50 -0500
Received: from il.qumranet.com ([62.219.232.206]:57824 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030211AbXAKIDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:03:49 -0500
Message-ID: <45A5EF63.3040601@qumranet.com>
Date: Thu, 11 Jan 2007 10:03:47 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: kvm-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kvm-devel] [RFC] Stable kvm userspace interface
References: <45A39A97.5060807@qumranet.com> <45A39D0D.7090007@garzik.org> <200701110834.43800.arnd@arndb.de>
In-Reply-To: <200701110834.43800.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> I still think that in the long term, we should migrate to
> new system calls and a special file system for kvm, which
> might be non-mountable. 

The inode-per-vm and inode-per-vcpu approach sort-of-implies a 
nonmountable special filesystem, so with the proposed change, we'll be 
halfway there.



-- 
error compiling committee.c: too many arguments to function

