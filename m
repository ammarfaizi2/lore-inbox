Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbULUJnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbULUJnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 04:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbULUJnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 04:43:08 -0500
Received: from web60608.mail.yahoo.com ([216.109.119.82]:5262 "HELO
	web60608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261601AbULUJnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 04:43:02 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=QXbDC5knhffwxWgHV+ogi/Mu1XkwsF00cjcDXir4QxwdrTomSHviLpRxtED92CCaalTHYKdj9bHVrlUZdzUuE4NmDYJj9ip4P0lONj3UwT8Qhoxez1pOt1mojlmb0cuqVewFCyzPPUxKSwav9o44x2UeWyk13zT9AUXcI6fbklQ=  ;
Message-ID: <20041221094302.14478.qmail@web60608.mail.yahoo.com>
Date: Tue, 21 Dec 2004 01:43:02 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re: Printk output on console
To: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ace3f33d0412210124520d6c80@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi srinivas,
     My question is "We are having lot more printk
statements in the kernel source files. While the
kernel is in execution where the output of all these
statements will go? and can we redirect the output of
printk to our console?
     Please help me. Also I have one more error after
having compiled my new kernel 2.6.9. After booting it
shows the following error

"Kernel panic syncing unable to mount block(0,0) VFS
specify root =LABEL correctly"
  Do u know how to deal with it?

Thanks,
selva
--- srinivas naga vutukuri
<srinivas.vutukuri@gmail.com> wrote:

> Hi Selva,
>  
>  I understood the question as where all/what all
> printks (with
>  line nos and the file names)
>  you are looking for is it. I think, in a normal
> printf  using the
>  macros __FILE__ and __LINE__ will give that...
>  
>  ex:
>  printk(KERN_ERR "%s: Driver Initialisation failed",
> __FILE__);
>  Is this helpful...
>  
> Regards,
> srinivas.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 
