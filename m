Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVCIKgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVCIKgC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVCIKf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:35:29 -0500
Received: from web60606.mail.yahoo.com ([216.109.118.244]:35417 "HELO
	web60606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262282AbVCIKcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:32:48 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Fodyf7XpGdn8cDSDdQ44mYXNysgs67GbmeKhwKM2m4tzpLgLd6D61KUHaCnsWFryISc+BVuq4I3bsc/DYeTrfP4YKD3xTvpzAE/w8cKESzMJ/wMV2NkeXYQG+bOFlRyWBPYCh8BwK7o+0QvrIhPgpX2wFbzhZiR+LX57r8e/mxs=  ;
Message-ID: <20050309103248.84827.qmail@web60606.mail.yahoo.com>
Date: Wed, 9 Mar 2005 02:32:48 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re: Random number generator in Linux kernel
To: vintya@excite.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        I think ur idea of generating a random number
with a seed will not be effective. The kernel comes up
with true random number generation by using the random
interaction of device drivers with the kernel. I think
that will be more effective than ur logic. It provides
true randomness and it avoids any guess. 
For more details u please refer the book ' Linux
kernel development' by Robert M Love Appendix C kernel
Random Number Generator. If u still want to stick to
ur own logic then u can implement it as a function
inside the kernel.

Regards,
selva

--- Vineet Joglekar <vintya@excite.com> wrote:
> 
> Hi all,
> 
> Can someone please tell me where can I find and
> which random/pseudo-random number generator can I
> use inside the linux kernel? (2.4.28)
> 
> I found out 1 function get_random_bytes() in
> linux/drivers/char/random.c but thats not what I
> want.
> 
> I want a function where I will be supplying a seed
> to that function as an input, and will get a random
> number back. If same seed is used, same number
> should be generated again.
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
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/
