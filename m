Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbSKVB00>; Thu, 21 Nov 2002 20:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbSKVB00>; Thu, 21 Nov 2002 20:26:26 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:32450 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267263AbSKVB0Z>;
	Thu, 21 Nov 2002 20:26:25 -0500
Message-ID: <3DDD8811.752CA2C4@us.ibm.com>
Date: Thu, 21 Nov 2002 17:27:45 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: davids@webmaster.com
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP memory pressure question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         When a Linux machine has reached the tcp_mem limit, what will happen to 
> 'write's on non-blocking sockets? Will they block until more TCP memory is 
> available? Will they return an error code? ENOMEM?
> 
>         If it varies by kernel version, details about different versions would be 
> extremely helpful. I'm most interested in late 2.4 kernels.
> 
>         Thanks in advance.
> 

Returns EAGAIN.
Fairly static ~late 2.4.

thanks,
Nivedita
