Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262994AbRE1H0X>; Mon, 28 May 2001 03:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262998AbRE1H0N>; Mon, 28 May 2001 03:26:13 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:47435 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S262994AbRE1H0C>; Mon, 28 May 2001 03:26:02 -0400
Date: Mon, 28 May 2001 10:25:51 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: initrd oops; still happens with 2.4.5ac2
Message-ID: <20010528102551.N11981@niksula.cs.hut.fi>
In-Reply-To: <20010526225825.A31713@lightning.swansea.linux.org.uk> <20010527192650.H11981@niksula.cs.hut.fi> <20010528001220.M11981@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010528001220.M11981@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Mon, May 28, 2001 at 12:12:20AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 12:12:20AM +0300, you [Ville Herva] claimed:
> On Sun, May 27, 2001 at 07:26:50PM +0300, you [Ville Herva] claimed:
> > 
> > I have a reproducible oops on 2.4.4ac17 at initrd unmount (see
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=99079948404775&w=2 for
> > details) that seems to be related:
> 
> Ok, some more info:                                                             
>                                                                                 
> 2.4.2-2 (redhat)       BOOTS OK                                                 
> 2.4.4ac17              OOPS                                                     
> 2.4.4ac17+av           OOPS                                                     
> 2.4.5                  OOPS                                                     
> 2.4.5ac1+av            OOPS                                                     
> 2.4.4                  BOOTS OK                                                 
> 2.4.4ac9               BOOTS OK                                                 
> 2.4.4ac10              BOOTS OK                                                 
> 2.4.4ac11              BOOTS OK                                                 
> 2.4.4ac12              fails to mount root ("Checking root filesystem.          
>                                              /dev/sdb is mounted.")             
> 2.4.4ac14              fails to mount root                                      
> 2.4.4ac15              OOPS                                                     

2.4.5ac2                 OOPS

The oops call trace seems to be the same as in 

http://marc.theaimsgroup.com/?l=linux-kernel&m=99079948404775&w=2

Any ideas?


-- v --

v@iki.fi
