Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSKTRF2>; Wed, 20 Nov 2002 12:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSKTRF2>; Wed, 20 Nov 2002 12:05:28 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:54728 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261646AbSKTREv>; Wed, 20 Nov 2002 12:04:51 -0500
Message-ID: <3DDBC230.6000908@nortelnetworks.com>
Date: Wed, 20 Nov 2002 12:11:12 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Steven French <sfrench@us.ibm.com>
Cc: acc@CS.Stanford.EDU, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 16 more potential buffer overruns in 2.5.48
References: <OFF1AA16C4.904AD55A-ON87256C77.00529B26@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven French wrote:

 > As long as unsigned char can never go above 255 the code should
> work.   It might have be more readable if it were defined as a  __u8
> instead of an unsigned char.

Technically there is nothing that guarantees that an unsigned char is <= 
8 bytes in size (although in practice it often is the case).

__u8 would definately be the way to go.


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

