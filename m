Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVIKWEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVIKWEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVIKWEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:04:53 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:51073 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750958AbVIKWEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:04:52 -0400
Message-ID: <4324A9F5.3020702@gmail.com>
Date: Mon, 12 Sep 2005 00:04:37 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/isicom old api rewritten (round 2)
References: <43236A02.9070301@gmail.com> <20050910165356.1ddbcc0c.akpm@osdl.org>
In-Reply-To: <20050910165356.1ddbcc0c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Jiri Slaby <jirislaby@gmail.com> wrote:
>  
>
>>This patch removes old api in pci probing and replaces it with new.
>> Firmware loading added.
>>    
>>
>> Patch is here for its size (40 KiB):
>> http://www.fi.muni.cz/~xslaby/lnx/isi_main.txt
>>    
>>
>
>40k isn't large - please include such patches in the email.
>  
>
Thank you, Andrew, for your reply and hints, you sent.


Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 drivers/char/isicom.c  | 2005 
++++++++++++++++++++++++-------------------------
 include/linux/isicom.h |   53 -
 2 files changed, 1004 insertions(+), 1054 deletions(-)

Now, it is 80k:

http://www.fi.muni.cz/~xslaby/lnx/isicom.txt

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

