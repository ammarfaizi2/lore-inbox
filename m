Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270445AbTHQRiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270448AbTHQRiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 13:38:25 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:62226 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270445AbTHQRiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 13:38:24 -0400
Message-ID: <3F3FBDF9.5020007@yahoo.com>
Date: Sun, 17 Aug 2003 13:40:09 -0400
From: Brandon Stewart <rbrandonstewart@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hot swapping USB mouse in X window system
References: <200308172048.15232.arvidjaar@mail.ru>
In-Reply-To: <200308172048.15232.arvidjaar@mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, that works. I knew about /dev/input/mice, but I didn't use it 
because one mouse was PS/2 and the other was IMPS/2. But it appears to 
figure things out on it's own. Thanks.

-Brandon

Andrey Borzenkov wrote:

>>1) If a mouse is not detected at the start of X windows, that mouse will 
>>not be checked for during the operation of X windows.
>>2) If a mouse is detected at the start of X windows, then the device 
>>corresponding to that mouse cannot be released until X windows is stopped
>>    
>>
>
>Use /dev/input/mice, it multiplexes all mice found and exists even if no 
>device is currentrly available.
>
>Under 2.6 I can "hot-plug" serial and PS2 mouse this way and use both at the 
>same time.
>
>-andrey
>

