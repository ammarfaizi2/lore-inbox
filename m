Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSKBXvr>; Sat, 2 Nov 2002 18:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261507AbSKBXvr>; Sat, 2 Nov 2002 18:51:47 -0500
Received: from [212.45.9.156] ([212.45.9.156]:8066 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S261506AbSKBXvq>;
	Sat, 2 Nov 2002 18:51:46 -0500
Message-ID: <3DC46643.5060909@yahoo.com>
Date: Sun, 03 Nov 2002 02:56:51 +0300
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021014
X-Accept-Language: ru, en
MIME-Version: 1.0
To: "Benjamin LaHaise" <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Larger IO bitmap?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Benjamin LaHaise wrote:
>> you are using megabytes for your TSS's only !
> Keep in mind that a task's io bitmap is now lazily allocated, so by 
> default no memory will be allocated for it.
Thanks, indeed browsing the 2.5 sources
at BK I see it is already done that way.
Had to upgrade before asking, as it doesn't
seem to be the case for 2.4(.19).
But then what are the reasons for the IO
bitmap to still be small at all? Are there
any reasons left?

> A similar enhancement 
> for large vs small io bitmaps could be made by allowing the task io 
> bitmap to be a variable size.
But is it really important?

