Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbSI3Vuy>; Mon, 30 Sep 2002 17:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSI3Vuy>; Mon, 30 Sep 2002 17:50:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32531 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261369AbSI3Vux>;
	Mon, 30 Sep 2002 17:50:53 -0400
Message-ID: <3D98C863.10302@pobox.com>
Date: Mon, 30 Sep 2002 17:55:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kent Yoder <key@austin.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.5.39 was Re: [PATCH] pcnet32 cable status check
References: <Pine.LNX.4.44.0209301639010.14068-100000@ennui.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Yoder wrote:
>>I just added mii_check_media() to drivers/net/mii.c.  It's in the latest 
>>2.5.x snapshot, 
>>ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/patch-2.5.39-bk2.bz2
> 
> 
>   That looks like just what the doctor ordered, but unfortunately it looks 
> like 2.5.39-bk2 is oopsing on boot on this machine.

for the purposes of testing, you can copy drivers/net/mii.c and 
include/linux/mii.h directly into 2.4.x at those same locations.

