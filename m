Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317095AbSFDLlK>; Tue, 4 Jun 2002 07:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316592AbSFDLlK>; Tue, 4 Jun 2002 07:41:10 -0400
Received: from rammstein.mweb.co.za ([196.2.53.175]:9865 "EHLO
	rammstein.mweb.co.za") by vger.kernel.org with ESMTP
	id <S316587AbSFDLlH>; Tue, 4 Jun 2002 07:41:07 -0400
To: Hossein Mobahi <hmobahi@yahoo.com>, linux-kernel@vger.kernel.org,
        linux-c-programming@vger.kernel.org
From: bonganilinux@mweb.co.za
Subject: Re: problem with <asm/semaphore.h>
Date: Tue, 4 Jun 2002 11:41:01 GMT
X-Mailer: Endymion MailMan Standard Edition v3.0.33
Message-Id: <E17FCaW-0002V9-00@rammstein.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you a trying to include a file from the linux source
which will not work for use-space apps. Try using 
#include <semaphore.h> instead 


> Hi
> 
> I compiled the following code with gcc under Redhat
> 7.2 :
> 
> #include <asm/semaphore.h>
> main()
> {
>     struct semaphore sum;
> }
> 
> It doesn't compile, saying "storage size of `sem'
> isn't known".
> Please guide me how to fix it.
> 
> Sincerely
> 
> --Hossein Mobahi
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! - Official partner of 2002 FIFA World Cup
> http://fifaworldcup.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


---------------------------------------------
This message was sent using M-Web Airmail.
JUST LIKE THAT
Are you ready for 10-digit dialling on the 8th of May?
To find out how this will affect your Internet connection go to www.mweb.co.za/ten
http://airmail.mweb.co.za/


