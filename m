Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUHDKac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUHDKac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUHDKab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:30:31 -0400
Received: from tapuz.safe-mail.net ([212.68.149.115]:36327 "EHLO
	tapuz.safe-mail.net") by vger.kernel.org with ESMTP id S264045AbUHDKaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:30:18 -0400
X-SMType: Regular
X-SMRef: N1-fn04EQGj
Message-ID: <4110BAC7.5010209@safe-mail.net>
Date: Wed, 04 Aug 2004 18:30:31 +0800
From: Liu Tao <liutao@safe-mail.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Add a writer prior lock methord for rwlock
References: <4110A7AF.2060903@safe-mail.net> <200408041145.07452.oliver@neukum.org>
In-Reply-To: <200408041145.07452.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:

>Am Mittwoch, 4. August 2004 11:09 schrieb Liu Tao:
>  
>
>>The patch adds the write_forcelock() methord, which has higher priority than
>>read_lock() and write_lock(). The original read_lock() and write_lock() 
>>is not
>>touched, and the unlock methord is still write_unlock();
>>    
>>
>
>It seems to me that with this a recursive read_lock() with
>a read lock already held may deadlock.
>
>	Regards
>
>		Oliver
>

Can you give an example path?
Thanks
