Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSKHVYF>; Fri, 8 Nov 2002 16:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262424AbSKHVYF>; Fri, 8 Nov 2002 16:24:05 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:62214 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S262418AbSKHVYF>; Fri, 8 Nov 2002 16:24:05 -0500
Message-ID: <3DCC2D01.6050309@google.com>
Date: Fri, 08 Nov 2002 13:30:41 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Failed writes marked clean?
References: <3DCC1EB5.4020303@google.com> <3DCC252F.65C0F70B@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Also, think about what a write error _means_.  Unless the disk is truly
>ancient, it means that the device has run out of alternate space for
>the block, or all writes are failing.  ie: it is a serious failure.
>  
>
I've seen all sorts of interesting drive failure modes, including losing 
communications with the drive for a short period and then having it come 
back almost as good as new.  We've had some data corruption on flaky 
drives and I'm guessing this has something to do with it.

I'm going to sit down with our application developers and see what they 
want to see from their end and see what I can do.

    Ross


