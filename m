Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268520AbUHYHlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268520AbUHYHlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268525AbUHYHlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:41:04 -0400
Received: from zenon.apartia.fr ([82.66.93.83]:12738 "EHLO zenon.apartia.com")
	by vger.kernel.org with ESMTP id S268520AbUHYHk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:40:59 -0400
Message-ID: <412C428A.1080606@apartia.fr>
Date: Wed, 25 Aug 2004 09:40:58 +0200
From: Laurent CARON <lcaron@apartia.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040722 Debian/1.7.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
References: <412B5B35.7020701@apartia.fr>	<20040824092533.65cb32da.rddunlap@osdl.org> <20040824113407.287f0408.davem@redhat.com>
In-Reply-To: <20040824113407.287f0408.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>On Tue, 24 Aug 2004 09:25:33 -0700
>"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
>  
>
>>| --------------
>>| drivers/net/net.o(.text+0x17550): In function `tg3_request_firmware': : 
>>| undefined reference to `request_firmware'
>>| drivers/net/net.o(.text+0x17652): In function `tg3_request_firmware': : 
>>| undefined reference to `release_firmware'
>>| -------------
>>| 
>>| Any clue?
>>| 
>>| PS: I can include a part of my .config
>>
>>You need to enable CONFIG_EXPERIMENTAL and CONFIG_HOTPLUG
>>and then CONFIG_FW_LOADER in the Library routines menu.
>>    
>>
>
>Oh on the contrary, I've never seen a call to request_firmware()
>in any copy of the tg3 driver and that's strange being that I'm
>the maintainer. :-)
>
>People, if you're going to use patched up kernels, report your
>problems to the people you got the kernel from.  Thanks.
>  
>

My mistake, I forgot to mention I was using a debian-source :(

Laurent

