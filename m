Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267242AbUF0ClJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267242AbUF0ClJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 22:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUF0ClJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 22:41:09 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:4986 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267242AbUF0ClH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 22:41:07 -0400
Message-ID: <40DE32C9.1040507@yahoo.com.au>
Date: Sun, 27 Jun 2004 12:36:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-np1
References: <40DD4928.9090108@yahoo.com.au> <40DD6B61.1080003@gmx.de>
In-Reply-To: <40DD6B61.1080003@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Hi,
> 
> Nick Piggin wrote:
> 
>> http://www.kerneltrap.org/~npiggin/2.6.7-np1.gz
>>
>> This applies against 2.6.7-mm2 and 2.6.7-bk8 with some offsets.
> 
> 
> 
> it breaks a bit hfs(+) and reiser4: Somehow PageActive() seems to be 
> gone...so I cannot compile.
> 

Hmm thanks, I obviously can't use grep. I'll fix hfs.

PageActive is replaced with PageActiveMapped and PageActiveUnmapped.
