Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTKORyT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 12:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTKORyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 12:54:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:48345 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261879AbTKORyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 12:54:18 -0500
Message-ID: <3FB6685A.8010607@marcush.de>
Date: Sat, 15 Nov 2003 18:54:34 +0100
From: Marcus Hartig <marcus@marcush.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031021
X-Accept-Language: en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 /-mm3 SATA siimage - bad disk performance
References: <3FB5B74E.5080707@marcush.de> <3FB5EDC1.8010805@gmx.de>
In-Reply-To: <3FB5EDC1.8010805@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:

> I have a similar problem: With 2.4.22-ac3 I had 37mb/sec with my Samsung 
> HD and 49MB/sec with IBM/Hitachi, now with 2.6 (all I tried, including 
> test9-mm2) I had only 20mb/sec for Samsung and about 39mb/sec for the 
> IBM. Motherboard is Abit NF7-S Rev2.0, as well, so same situation with 
> the siimage 1.06 driver. I wanted to run some dd tests as well, but it 
> is a real performance hit. Playing with readahead or other hdparm 
> options didn't help either.

I get a tip from Mark Hahn to set the pci latency to 64. And wow, with 
fedora 2.4.22 kernel I get then 41MB/sec with max_k_p_r 128. But,... 
after copying big files I get ext3-fs erros, cannot read inode etc and a
bus error. Bumm!

Maybe it runs better with your harddrives.

Marcus

