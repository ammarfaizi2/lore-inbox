Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292847AbSCEGYu>; Tue, 5 Mar 2002 01:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293614AbSCEGYe>; Tue, 5 Mar 2002 01:24:34 -0500
Received: from chamber.cco.caltech.edu ([131.215.48.55]:26075 "EHLO
	chamber.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S292847AbSCEGYc>; Tue, 5 Mar 2002 01:24:32 -0500
From: bryanr@bryanr.org
Message-ID: <3C8464AB.3020404@bryanr.org>
Date: Mon, 04 Mar 2002 22:24:43 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: aryan aru <aryan222is@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: netlink vs ioctl
In-Reply-To: <20020305002843.30834.qmail@web21206.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aryan aru wrote:
> When used ioremap_nocache to map from user space to
> kernel space does it do cache flush ?

I'd guess ioremap_nocache marks the area as uncacheable,
so that all memory accesses bypass the cache and go
directly to physical memory. best way to find out
is to check the code ;)

-Bryan

