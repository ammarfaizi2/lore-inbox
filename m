Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbVEGOUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbVEGOUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 10:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbVEGOUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 10:20:34 -0400
Received: from web60522.mail.yahoo.com ([209.73.178.170]:26772 "HELO
	web60522.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263199AbVEGOU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 10:20:27 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=W6tUjIGqUdan0t2K8gcCuOTYsYlJVLGv2P2PMr/TWFGBXukXsw0g9RWG6D5aJy147HXsA+vlH6NKAFanSI2nh1moui2EjdQ2KXIP0L+7T3wj5x2IF40WErLbK6va2f6bd0vdjqEeft+QHUV/LI14waBkzgw5nlKc7gzvbYt52XY=  ;
Message-ID: <20050507142027.61160.qmail@web60522.mail.yahoo.com>
Date: Sat, 7 May 2005 07:20:26 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: compiling "hello world" kernel module on 2.6 kernel
To: Espen =?ISO-8859-1?Q?=20=22Fjellv=E6r=22?= Olsen 
	<espenfjo@gmail.com>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Espen, but it didnt worked.
Please tell me where i am wrong:
hello.c is at /local/usr/linux-2.6.5-7.162
i did a cd to /local/usr/linux-2.6.5-7.162
created makefile called Makefile.1 as u suggested.
and did a make -f Makefile.1

--- Espen Fjellvær Olsen <espenfjo@gmail.com> wrote:
> On 5/7/05, li nux <lnxluv@yahoo.com> wrote:
> > 
> > default:
> >          $(MAKE) -C $(KERNELDIR) M=$(PWD) modules
> 
> Try changing this to:
> " $(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules"
> 
> 
> -- 
> Mvh / Best regards
> Espen Fjellvær Olsen
> espenfjo@gmail.com
> Norway
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


		
Discover Yahoo! 
Find restaurants, movies, travel and more fun for the weekend. Check it out! 
http://discover.yahoo.com/weekend.html 

