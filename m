Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWIGPUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWIGPUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWIGPUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:20:10 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:22025 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751819AbWIGPUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:20:08 -0400
Message-ID: <45003985.7060304@sw.ru>
Date: Thu, 07 Sep 2006 19:23:49 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
CC: Adrian Bunk <bunk@stusta.de>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>, devel@openvz.org, mikpe@it.uu.se,
       sam@ravnborg.org
Subject: Re: [PATCH] fail kernel compilation in case of unresolved symbols
 (v2)
References: <44FFEE5D.2050905@openvz.org> <20060907110513.GA22319@aepfle.de> <20060907111329.GI25473@stusta.de> <20060907122607.GA22882@aepfle.de>
In-Reply-To: <20060907122607.GA22882@aepfle.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> On Thu, Sep 07, Adrian Bunk wrote:
> 
> 
>>If any module shipped with the kernel has in any configuration 
>>unresolved symbols that's a bug that should be reported, not ignored.
> 
> 
> Yes, but on request when building the package. Not per default.
> I probably missed the reason why this is now suddenly a problem.
It is not that sudden at all. I experienced this problem many times so far
and working with a build system came to the idea of failing
builds when there are unresolved symbols.

I'm pretty sure that having this patch in mainstream
will make unresolved symbols a rare problem as many of them will be fixed soon.
So I'm pretty agree with Adrian that modules with unresolved symbols is a bug
and it MUST be fixed.
I would be very much interested to hear Andrew opinion on this as
he probably makes kernels even more often than any of us :)

Thanks,
Kirill

