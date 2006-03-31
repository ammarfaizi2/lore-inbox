Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWCaR03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWCaR03 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWCaR03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:26:29 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:16560 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932070AbWCaR03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:26:29 -0500
Message-ID: <60485.128.237.233.65.1143825987.squirrel@128.237.233.65>
In-Reply-To: <442C81BC.7030605@shaw.ca>
References: <5W8lY-1wF-29@gated-at.bofh.it> <442C81BC.7030605@shaw.ca>
Date: Fri, 31 Mar 2006 12:26:27 -0500 (EST)
Subject: Re: cannot get clean 2.4.20 kernel to compile
From: "George P Nychis" <gnychis@cmu.edu>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see...

here is my gcc version:
gcc version 3.3.6 (Gentoo 3.3.6, ssp-3.3.6-1.0, pie-8.7.8)

Is it too new?

Thanks!
George


> George P Nychis wrote:
>> Hi,
>> 
>> I have downloaded the 2.4.20 kernel from ftp.kernel.org, have checked
>> its sign, and no matter what I try I cannot get it to compile.
>> 
>> I do a make mrproper, I then do make dep which is fine, but then i try
>> "make bzImage modules modules_install", selecting all the defaults, and
>> get an SMP header error: http://rafb.net/paste/results/QzIq7v86.html
>> 
>> I then disable SMP support and get: 
>> http://rafb.net/paste/results/muYA9t12.html
>> 
>> I even tried using my config from the 2.4.32 kernel which works
>> perfectly fine, and I also get the sched errors.
> 
> What gcc version? Some old kernels might not be buildable with newer 
> compilers.
> 
> -- Robert Hancock      Saskatoon, SK, Canada To email, remove "nospam" from
> hancockr@nospamshaw.ca Home Page: http://www.roberthancock.com/
> 
> 
> 


-- 

