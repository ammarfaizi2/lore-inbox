Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVCHM7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVCHM7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVCHM7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:59:23 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:37072 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262043AbVCHM7K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:59:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cMt5DlaewNiKDr1sUbFkrQykDvmAWn2+0buOKAU23tdzsHTLJBdmSu2ogKShegfLZxgrCZzfvP9QRuQDHVrbM61NzaN6J3oPPdZky0/pOTMriSXr18bcCoo8D9Sx4IknxOWydE0KG/x6XDkasI928BtChoPHO0GEiU4ubz3+ujo=
Message-ID: <84bd26ef050308045943a1659b@mail.gmail.com>
Date: Tue, 8 Mar 2005 09:59:08 -0300
From: =?ISO-8859-1?Q?Dar=EDo_Mariani?= <mariani.dario@gmail.com>
Reply-To: =?ISO-8859-1?Q?Dar=EDo_Mariani?= <mariani.dario@gmail.com>
Subject: Re: Random number generator in Linux kernel
Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
In-Reply-To: <20050307231853.9F661B6E7@xprdmailfe20.nwk.excite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20050307231853.9F661B6E7@xprdmailfe20.nwk.excite.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I understand the kernel generates random numbers gathering
data from several entropy sources, you will never get repetability
from there. Two options I know of:

1) The standard C library has the functions rand and random, wich
seems to have a decent distribution of the random numbers.

2) If you use C++, the Boost library (www.boost.org) has an excelent
set of options for generating random numbers.

              Darío

On Mon,  7 Mar 2005 18:18:53 -0500 (EST), Vineet Joglekar
<vintya@excite.com> wrote:
> 
> Hi all,
> 
> Can someone please tell me where can I find and which random/pseudo-random number generator can I use inside the linux kernel? (2.4.28)
> 
> I found out 1 function get_random_bytes() in linux/drivers/char/random.c but thats not what I want.
> 
> I want a function where I will be supplying a seed to that function as an input, and will get a random number back. If same seed is used, same number should be generated again.
> 
> Can anybody please help me with that?
> 
> Thanks and regards,
> 
> Vineet.
> 
> _______________________________________________
> Join Excite! - http://www.excite.com
> The most personalized portal on the Web!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-c-programming" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
That is not dead which can eternal lie,
and with strange aeons, even death may die.
