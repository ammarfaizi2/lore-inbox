Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264657AbUD1NBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264657AbUD1NBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUD1NBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:01:49 -0400
Received: from [203.97.82.178] ([203.97.82.178]:59536 "EHLO treshna.com")
	by vger.kernel.org with ESMTP id S264657AbUD1NBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:01:48 -0400
Message-ID: <408FAB17.3090305@treshna.com>
Date: Thu, 29 Apr 2004 01:01:11 +1200
From: Dru <andru@treshna.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel lockup on alpha with heavy IO
References: <408C75E4.50908@treshna.com> <20040426131319.A9952@jurassic.park.msu.ru> <408E3D8C.8090504@treshna.com> <20040427201013.A14559@jurassic.park.msu.ru>
In-Reply-To: <20040427201013.A14559@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:

>On Tue, Apr 27, 2004 at 11:01:32PM +1200, Dru wrote:
>  
>
>>I am not having much luck with the firmware upgrade.
>>It gets up to saying Copying up1500fw.txt from dva0 . . .  and
>>just sits there. It never reachs albasrm.rom file.
>>    
>>
>
>Well, it was about 1.5 years ago when I upgraded the firmware last
>time, so I don't recall all details... Anyway, from memory:
>- make sure that you get to SRM prompt right after reset or
>  powerup, i.e. 'auto_action' is set to 'halt';
>- IIRC, UP1500 has problems with some floppy drives, and it
>  may require 2-3 resets before it reads the rom image file
>  successfully.
>
>  
>
Finally got firmware to update, the up1500 board is a bit
sturburn. Many repeated attempts and changing around
floppy drives was successful. thanks for the help.

