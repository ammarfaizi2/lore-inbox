Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVL2KUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVL2KUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 05:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVL2KUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 05:20:55 -0500
Received: from c158130.vh.plala.or.jp ([210.150.158.130]:20619 "EHLO
	mvs2.plala.or.jp") by vger.kernel.org with ESMTP id S932359AbVL2KUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 05:20:54 -0500
Message-ID: <43B3B94D.4040000@gmail.com>
Date: Thu, 29 Dec 2005 19:24:13 +0900
From: cai <junjiec@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: "OGAWA Hirofumi ;penberg@cs.Helsinki.FI" 
	<hirofumi@mail.parknet.co.jp>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][fat] use mpage_readpage when cluster size is page-alignment
References: <ca992f110512272356l379dccc5k6288c28411ff7af4@mail.gmail.com>	<87u0ctwf93.fsf@devron.myhome.or.jp> <43B3844A.5050401@gmail.com> <87y824p8ft.fsf@devron.myhome.or.jp>
In-Reply-To: <87y824p8ft.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

>Ah, yes.
>
>But if cluster is not fragmented it shouldn't fall back, and rather it
>will get advantage.  And I guess, even if it fall back to
>block_read_full_page(), it would be very trivial.
>
>What do you think?   We may need benchmark...
>  
>
i think you are right, i didn't think of adjacent-cluster
so maybe just calling mpage_readpage{s} is enough.

thanks.
                         junjie

