Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbTL3M7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 07:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265779AbTL3M7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 07:59:19 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:5524 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S265775AbTL3M7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 07:59:17 -0500
Message-ID: <3FF176A0.5070904@elegiac.net>
Date: Tue, 30 Dec 2003 13:59:12 +0100
From: dju` <dju.ml@elegiac.net>
Organization: [elgc]
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 + logitech wheel mouse optical usb
References: <3FF04FF3.70006@elegiac.net> <Pine.LNX.4.58.0312290956110.11299@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312290956110.11299@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Just for fun, try changing include/linux/time.h, to make the
> 
> 	#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> 
> just be a simple
> 
> 	#define INITIAL_JIFFIES 0UL
> 
> and see if that makes any difference... 
> 
> 		Linus

No, that didn't change anything.

-- 
--dju`

PS: Please CC me.
