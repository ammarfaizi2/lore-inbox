Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRKCXCh>; Sat, 3 Nov 2001 18:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRKCXC1>; Sat, 3 Nov 2001 18:02:27 -0500
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:41671
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S275743AbRKCXCO>; Sat, 3 Nov 2001 18:02:14 -0500
From: arjan@fenrus.demon.nl
To: skraw@ithnet.com (Stephan von Krawczynski)
Subject: Re: Adaptec vs Symbios performance
cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111032253.XAA20342@webserver.ithnet.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E1609mt-0007WE-00@fenrus.demon.nl>
Date: Sat, 03 Nov 2001 23:01:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200111032253.XAA20342@webserver.ithnet.com> you wrote:

> Hello Justin, hello Gerard                                            
>                                                                      
> I am looking currently for reasons for bad behaviour of aic7xxx driver
> in an shared interrupt setup and general not-nice behaviour of the    
> driver regarding multi-tasking environment.                           
> Here is what I found in the code:                                     

>         * It would be nice to run the device queues from a           
>         * bottom half handler, but as there is no way to             
>         * dynamically register one, we'll have to postpone           
>         * that until we get integrated into the kernel.              
>         */                    

sounds like a good tasklet candidate......
