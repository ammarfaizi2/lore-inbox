Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSCKTeS>; Mon, 11 Mar 2002 14:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289815AbSCKTeK>; Mon, 11 Mar 2002 14:34:10 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:55543 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S290120AbSCKTd4>; Mon, 11 Mar 2002 14:33:56 -0500
Date: Tue, 12 Mar 2002 01:06:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: brad@linuxcanada.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multi-threading
Message-ID: <20020312010618.A32259@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20020311182111Z310364-889+120750@vger.kernel.org> Brad Pepers wrote:
> There was a message posted by Jim Starkey about his experiences using threads 
> on Linux and the problems debugging them.  It came down to two things:

> 2. Linux is missing an atomic use-count mechanism which returns values like
>    the Microsoft InterlockedIncrement/Decrement functions do.

Can't this be done using atomic_dec_and_test() and the likes ?
Google tells me that windoze InterlockedIncrement/Decrement stuff
does the almost same thing. Why can't refcounting be
implemented using just atomic_inc/dec and/or atomic_inc/dec_and_test ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
