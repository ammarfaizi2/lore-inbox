Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268717AbTBZLj7>; Wed, 26 Feb 2003 06:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268718AbTBZLj7>; Wed, 26 Feb 2003 06:39:59 -0500
Received: from palrel11.hp.com ([156.153.255.246]:14571 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S268717AbTBZLjz>;
	Wed, 26 Feb 2003 06:39:55 -0500
Message-ID: <3E5CA785.8010801@india.hp.com>
Date: Wed, 26 Feb 2003 17:09:49 +0530
From: vishwas@india.hp.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020815
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jpiszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about DMA and cd burning.
References: <3E5C4ECD.7020806@lucidpixels.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

use: hdparam -d1 /dev/<hdX>

to enable DMA, if it still says it cannot enable DMA.
try enabling the xfermode,which gives me the same
performace as DMA enabled.

hdparam -X<num> /dev/<hdX>
     put num greater than 32..like 33,34 etc  (for multiword DMA)
     OR  greater that 64....like 65 66 etc.   (for UltraDMA)

-vvp









