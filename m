Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314769AbSE0JLF>; Mon, 27 May 2002 05:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSE0JLE>; Mon, 27 May 2002 05:11:04 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5138 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314769AbSE0JLD>;
	Mon, 27 May 2002 05:11:03 -0400
Message-ID: <3CF1E945.3090009@evision-ventures.com>
Date: Mon, 27 May 2002 10:07:33 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Skip Ford <skip.ford@verizon.net>
CC: Sebastian Droege <sebastian.droege@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 ide-scsi compile fix
In-Reply-To: <3CEF8815.C7C13D39@wxs.nl> <3CEFAB05.62937A75@wxs.nl> <20020526135058.493da149.sebastian.droege@gmx.de> <20020526222844.HWX25262.pop015.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Skip Ford napisa?:
> Sebastian Droege wrote:
> 
>>BTW: why do I get an oops (reported 2 or 3 times but no answers)
>>when mounting cdroms since 2.5.7 or something?
> 
> 
> Because the ide-scsi code hasn't caught up to Martin's IDE cleanup
> changes yet.

That's not the case. The problem is simply the SCSI part of the game,
(80% of certainlity) which seems to don't deal properly with hot pluggable
drives right now.

