Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290528AbSAQXg0>; Thu, 17 Jan 2002 18:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290530AbSAQXgQ>; Thu, 17 Jan 2002 18:36:16 -0500
Received: from f79.law11.hotmail.com ([64.4.17.79]:12563 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290528AbSAQXgF>;
	Thu, 17 Jan 2002 18:36:05 -0500
X-Originating-IP: [156.153.254.2]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
Date: Thu, 17 Jan 2002 15:35:59 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F79oay0q0NTY9agv3Su00012f71@hotmail.com>
X-OriginalArrivalTime: 17 Jan 2002 23:36:00.0033 (UTC) FILETIME=[B820B910:01C19FAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: "David S. Miller" <davem@redhat.com>
>
>    Even if we do not pass the value passed by the user
>    to the protocol specific code, I would like to cleanup
>    the code in socket.c to check for invalid values
>    upfront and save time and space in all the calls.
>
>Optimizing error cases never bears any fruit.

In this case, I certainly think it does. Could u give a
case as to why doing this would be harmful? I think the
only issue can be maintainability and doing the change
cleanly. But I think u are a good maintainer and will
accept the changes only if they are properly fixed.
Right :-)

Balbir

_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

