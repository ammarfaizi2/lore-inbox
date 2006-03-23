Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWCWBLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWCWBLw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWCWBLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:11:52 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:27445 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932171AbWCWBLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:11:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HiX0Yw9XgEBnsXSVjA44laxa09a95S1VHHNhb7+8oxKpOWU1wEoAGVaSSk08BXu06Jna8Kxvnyx/lPOB39a0Xs8Jci+YldvdEBuebR/z1Pj8Af5bSUX//weBhNWKIG61XXaTb6gJ/fpR7LeRFdVAHvdufzr29utjZ/cYhxgg/7g=
Message-ID: <4421F471.3030505@gmail.com>
Date: Thu, 23 Mar 2006 09:05:53 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.16 PATCH] some tail whitespace clean under subdirectory
 kernel
References: <44216EFF.6050503@gmail.com> <44219917.90806@gmail.com>
In-Reply-To: <44219917.90806@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Yi Yang napsal(a):
>   
>> This patch cleans some tail whitespaces under subdirectory kernel.
>>
>>
>> diffstat
>>  capability.c |   20 ++++++++++----------
>>  fork.c       |   12 ++++++------
>>  signal.c     |   14 +++++++-------
>>  sys.c        |   38 +++++++++++++++++++-------------------
>>  timer.c      |   18 +++++++++---------
>>  5 files changed, 51 insertions(+), 51 deletions(-)
>>
>> Signed-off-by: Yi Yang <yang.y.yi@gmail.com>
>>
>> --- a/kernel/capability.c.orig	2006-03-22 23:04:30.000000000 +0800
>> +++ b/kernel/capability.c	2006-03-22 23:07:06.000000000 +0800
>> @@ -5,7 +5,7 @@
>>   *
>>   * Integrated into 2.1.97+,  Andrew G. Morgan <morgan@transmeta.com>
>>   * 30 May 2002:	Cleanup, Robert M. Love <rml@tech9.net>
>> - */ 
>> + */
>>  
>>  #include <linux/capability.h>
>>  #include <linux/mm.h>
>> @@ -54,18 +54,18 @@ asmlinkage long sys_capget(cap_user_head
>>  
>>       if (version != _LINUX_CAPABILITY_VERSION) {
>>  	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
>> -		     return -EFAULT; 
>> +		     return -EFAULT;
>>     
> I think, it wants Lindent or something, not only delete tail whispaces, but also
> space indentation.
>
>   
Yes, there are too many such issues in kernel source tree, I don't know 
whether Linus uses
Lindent to reformat all the source code before release?
> regards,
> - --
> Jiri Slaby         www.fi.muni.cz/~xslaby
> ~\-/~      jirislaby@gmail.com      ~\-/~
> B67499670407CE62ACC8 22A032CC55C339D47A7E
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2.2 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iD8DBQFEIZkXMsxVwznUen4RAgXfAKCUZKR72rZajvm4FExJt/WsXJKYMwCglKH1
> sUu3C59ZI/r27ZmsZlFfAvM=
> =rGzw
> -----END PGP SIGNATURE-----
>
>   

