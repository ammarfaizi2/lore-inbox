Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274825AbRIZElj>; Wed, 26 Sep 2001 00:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274829AbRIZEl3>; Wed, 26 Sep 2001 00:41:29 -0400
Received: from mail.zmailer.org ([194.252.70.162]:31245 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S274825AbRIZElY>;
	Wed, 26 Sep 2001 00:41:24 -0400
Date: Wed, 26 Sep 2001 07:41:42 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Gangadhar Uppala <gangadhar.uppala@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to exchange data between Kernel & User Space
Message-ID: <20010926074142.E11046@mea-ext.zmailer.org>
In-Reply-To: <009101c1463e$8410e160$1f33a8c0@ganga.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009101c1463e$8410e160$1f33a8c0@ganga.wipro.com>; from gangadhar.uppala@wipro.com on Wed, Sep 26, 2001 at 09:21:25AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 09:21:25AM +0530, Gangadhar Uppala wrote:
> Hi All,
>     Here we are in need of a design decision . The problem is as follows:
> 
> We are writing device driver for network adapter, as part of this we need to
> exchange some information between user and kernel(driver) and vice versa. As
> i know this can be implemented using IOCTLs. Please suggest an alternative
> approach for this.

   Why the system supplied standard set of ioctls isn't enough ?
   Or is not extendible ?

   Something very special you need to do ?
   Is high bandwidth needed at this communication ?

   For normal network traffic the communication goes via kernel internal
   packet reception path, but if you want to do something totally different,
   suggesting alternates needs an idea of what you are aiming at.

> Please keep a copy for me, because i am not subscriber to this list.
> 
> Thanks
> Gangadhar

/Matti Aarnio
