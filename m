Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293183AbSBWTGA>; Sat, 23 Feb 2002 14:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293181AbSBWTFv>; Sat, 23 Feb 2002 14:05:51 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:46543 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S293180AbSBWTFi>; Sat, 23 Feb 2002 14:05:38 -0500
Message-ID: <3C77E76D.1000700@wanadoo.fr>
Date: Sat, 23 Feb 2002 20:03:09 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: ertzog <ertzog@bk.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.5 not compilling ramdisk
In-Reply-To: <Pine.LNX.4.21.0202232128480.5426-400000@dial-up-2.energonet.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ertzog wrote:
> A strange problem seems to be in drivers/block/rd.c:271
known issue :
-     sbh->bi_end_io(sbh, len >> 9);
+     sbh->bi_end_io(sbh);

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

