Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWH0JnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWH0JnE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWH0JnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:43:04 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:48569 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751368AbWH0JnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:43:01 -0400
Message-ID: <44F16923.9050609@slaphack.com>
Date: Sun, 27 Aug 2006 04:42:59 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: Reiser4 und LZO compression
References: <20060827003426.GB5204@martell.zuzino.mipt.ru> <20060827010428.5c9d943b.akpm@osdl.org>
In-Reply-To: <20060827010428.5c9d943b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 27 Aug 2006 04:34:26 +0400
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
>> The patch below is so-called reiser4 LZO compression plugin as extracted
>> from 2.6.18-rc4-mm3.
>>
>> I think it is an unauditable piece of shit and thus should not enter
>> mainline.
> 
> Like lib/inflate.c (and this new code should arguably be in lib/).
> 
> The problem is that if we clean this up, we've diverged very much from the
> upstream implementation.  So taking in fixes and features from upstream
> becomes harder and more error-prone.

Well, what kinds of changes have to happen?  I doubt upstream would care 
about moving some of it to lib/ -- and anyway, reiserfs-list is on the 
CC.  We are speaking of upstream in the third party in the presence of 
upstream, so...

Maybe just ask upstream?
