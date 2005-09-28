Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVI1AZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVI1AZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVI1AZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:25:19 -0400
Received: from packet.digeo.com ([12.110.80.53]:22659 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id S1751137AbVI1AZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:25:18 -0400
Message-ID: <4339E2DD.5000202@namesys.com>
Date: Tue, 27 Sep 2005 17:25:01 -0700
From: Nate Diller <nate@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] block cleanups: Add kconfig default iosched submenu
References: <4339C597.3070409@namesys.com> <20050927224121.GK2811@suse.de>
In-Reply-To: <20050927224121.GK2811@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 00:24:56.0964 (UTC) FILETIME=[0DED9440:01C5C3C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Sep 27 2005, Nate Diller wrote:
> 
>>Add a kconfig submenu to select the default I/O scheduler, in case 
>>anticipatory is not compiled in or another default is preferred.  Also, 
>>since no-op is always available, we should use it whenever the selected 
>>default is not.
>>
>>I saw a patch recently to add this option, and I don't think it got picked 
>>up.  This version is cleaner, since it eliminates all the #ifdef's in the 
>>code itself.
> 
> 
> Can you rebase this against latest -mm, it has the other patch you
> mentioned applied (in a more cleaned up version)? Thanks.
> 
The latest -mm on kernel.org seems to be 2.6.14-rc2-mm1, and the other patch does not seem to be 
included in that.  Is there a git tree I should be patching against?

Thanks

NATE
