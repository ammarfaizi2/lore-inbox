Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310549AbSCVAL3>; Thu, 21 Mar 2002 19:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310598AbSCVALT>; Thu, 21 Mar 2002 19:11:19 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:4503 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S310549AbSCVALE>;
	Thu, 21 Mar 2002 19:11:04 -0500
Message-ID: <3C9A758D.103@acm.org>
Date: Thu, 21 Mar 2002 18:06:37 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Tom Rini <trini@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
In-Reply-To: <E16oAoJ-0006RH-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>It's getting there.  The 'issue' is that the best way to fix it (maybe
>>2.4.20-pre1 even) is to backport the 2.5 zlib which doesn't have this
>>
>
>2.4.19ac has the shared zlib already. The zlib sharing stuff wasnt a 2.5
>patch backported - its a 2.4 fix that went forward
>
Since I did the original shared zlib patch and I did it to 2.5, either 
we have two patches floating around or you are incorrect.  If we have 
two patches, we need to resolve the situation.

-Corey


