Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274845AbRIZGLR>; Wed, 26 Sep 2001 02:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274846AbRIZGLI>; Wed, 26 Sep 2001 02:11:08 -0400
Received: from web11907.mail.yahoo.com ([216.136.172.191]:46092 "HELO
	web11907.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274845AbRIZGK6>; Wed, 26 Sep 2001 02:10:58 -0400
Message-ID: <20010926061124.61082.qmail@web11907.mail.yahoo.com>
Date: Tue, 25 Sep 2001 23:11:24 -0700 (PDT)
From: Kirill Ratkin <kratkin@yahoo.com>
Subject: Re: How to exchange data between Kernel & User Space
To: Gangadhar Uppala <gangadhar.uppala@wipro.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010926074142.E11046@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use mmap and see exmaple here:
http://www.kernelnewbies.org/code/mmap/

Regards,

--- Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> On Wed, Sep 26, 2001 at 09:21:25AM +0530, Gangadhar
> Uppala wrote:
> > Hi All,
> >     Here we are in need of a design decision . The
> problem is as follows:
> > 
> > We are writing device driver for network adapter,
> as part of this we need to
> > exchange some information between user and
> kernel(driver) and vice versa. As
> > i know this can be implemented using IOCTLs.
> Please suggest an alternative
> > approach for this.
> 
>    Why the system supplied standard set of ioctls
> isn't enough ?
>    Or is not extendible ?
> 
>    Something very special you need to do ?
>    Is high bandwidth needed at this communication ?
> 
>    For normal network traffic the communication goes
> via kernel internal
>    packet reception path, but if you want to do
> something totally different,
>    suggesting alternates needs an idea of what you
> are aiming at.
> 
> > Please keep a copy for me, because i am not
> subscriber to this list.
> > 
> > Thanks
> > Gangadhar
> 
> /Matti Aarnio
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Get email alerts & NEW webcam video instant messaging with Yahoo! Messenger. http://im.yahoo.com
