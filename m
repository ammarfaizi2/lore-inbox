Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313184AbSC1PlX>; Thu, 28 Mar 2002 10:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313186AbSC1PlD>; Thu, 28 Mar 2002 10:41:03 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:20907 "EHLO
	e23.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S313180AbSC1Pk6>; Thu, 28 Mar 2002 10:40:58 -0500
Message-ID: <3CA336F3.2080002@vnet.ibm.com>
Date: Thu, 28 Mar 2002 09:29:55 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thomas Hood <jdthood@mail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: proc_file_read() hack?
In-Reply-To: <20020323114004.92117.qmail@web10307.mail.yahoo.com>	<3C9F69F4.3010908@vnet.ibm.com> <1017085557.5263.335.camel@thanatos> 	<3CA20EDF.7080402@vnet.ibm.com> <1017277343.865.32.camel@thanatos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood wrote:


>>If that is true I am wondering how it could possibly be correct
>>since start will be used as a length which is greater than the
>>size of the page.
>>
> 
> start will be used as an offset, not as a length.
> 
> If you think the hack was a bad idea, I agree with you.
> But we can't change it without auditing all the proc read
> functions that use case #1.


Ahh...thanks for taking the trouble to answer all these questions :).  I 
obviously wasn't paying attention enough to see that start was *not* 
used as a length.  Sigh.  Anyway, yes I agree we cannot patch this 
without some serious review and I'm not going to volunteer today :).


-todd


