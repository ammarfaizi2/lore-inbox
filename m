Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265185AbSKFDXf>; Tue, 5 Nov 2002 22:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265544AbSKFDXf>; Tue, 5 Nov 2002 22:23:35 -0500
Received: from mail.tpgi.com.au ([203.12.160.57]:52440 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id <S265185AbSKFDXe>;
	Tue, 5 Nov 2002 22:23:34 -0500
Message-ID: <3DC7E2ED.5010306@tpg.com.au>
Date: Wed, 06 Nov 2002 02:25:33 +1100
From: Bill Leckey <bleckey@tpg.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kfree_skb query
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a driver that provides an ethernet like interface to a WAN 
link.  The device DMA's the data from me, then tells me when it's 
finished.  At that point I free the skb.  However I get the following 
warning

kernel: Warning: kfree_skb on hard IRQ d092c301

What is bad about calling kfree_skb from within a hard IRQ?  I'm afraid 
looking at the code that spat out the error message didn't help me, and 
since it's only a warning I'm assuming it's not fatal, but shouldn't be 
done for some reason.

Thanks.

Bill

-- 
Bill Leckey - Senior Software Design Engineer
TPG Research and Development
Ph: +61 2 62851711
Fax: +61 2 62853939

