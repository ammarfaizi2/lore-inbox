Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUE3HTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUE3HTp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 03:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUE3HTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 03:19:44 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:53910 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S261907AbUE3HTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 03:19:42 -0400
Message-ID: <40B98B0D.7090209@tomt.net>
Date: Sun, 30 May 2004 09:19:41 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Younggyun Koh <young@cc.gatech.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: seperate environments for different kernels
References: <Pine.GSO.4.58.0405292206320.2487@tokyo.cc.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0405292206320.2487@tokyo.cc.gatech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Younggyun Koh wrote:

> Hi,
> 
> i want to run linux 2.6.6 kernel, which needs upgrade of some system tools
> such as module-init-tools and nfs-utils. but other guys using the same
> machine with 2.4 kernel don't want me to upgrade them.
> 
> is there any way i can make different system tools installed when i boot
> with the different kernel images other than mounting root directory to the
> different partitions? (i can't create a new partition)

Modern distributions handle this more or less transparently. 
module-init-tools can call on modutils if it sees you're running a 2.4 
kernel.

-- 
Cheers,
André Tomt
