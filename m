Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbSJCP2x>; Thu, 3 Oct 2002 11:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSJCP2s>; Thu, 3 Oct 2002 11:28:48 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:12465 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261191AbSJCP2r>;
	Thu, 3 Oct 2002 11:28:47 -0400
Message-ID: <3D9C6376.5080802@colorfullife.com>
Date: Thu, 03 Oct 2002 17:34:14 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.40-ac1
References: <3D9C5827.70703@colorfullife.com> <1033658256.28814.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> The checks I did were that it seemed to produce the same data in both
> cases. So if it was wrong before (using set_bit) its probably wrong now.
 >
Which arch?
On ppc, __set_bit() stores in big endian format, i.e. the cpu_to_le32 
would be wrong
I try to figure out what set_bit() does.

--
	Manfred

